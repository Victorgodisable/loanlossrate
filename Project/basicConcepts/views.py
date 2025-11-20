from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect, StreamingHttpResponse
from joblib import load
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login
from django.shortcuts import render, redirect
from .models import ProductDetail,LLRPricingAssumption,SalesProjection,PaymentPlanProjection,Reason
import csv
import re
from django.urls import reverse
from django.utils import timezone
import xlwt
from django.contrib.auth import logout
import locale
import calendar
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
import os
from django.db.models import Q
from django.db.models import Max
from django.contrib import messages
import csv
from math import sqrt
import re
from django.core.exceptions import MultipleObjectsReturned
import base64
import io
import joblib
import json
from django.http import JsonResponse
from django.db import transaction
from django.http import HttpResponse
from django.core.files.storage import FileSystemStorage
from django.conf import settings
import json
from decimal import Decimal
from django.contrib.auth.decorators import login_required, user_passes_test

def is_superuser(user):
    return user.is_authenticated and user.is_superuser

def user_login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        
        if username and password:
            user = authenticate(request, username=username, password=password)
            
            if user:
                login(request, user)
                # Redirect to a success page or home page
                return redirect('index')
            else:
                # Return an invalid login error message
                error = 'Invalid login credentials'
        else:
            # Return an error message if fields are empty
            error = 'Both username and password are required'
    else:
        error = None

    return render(request, 'login.html', {'error': error})

def logout_view(request):
    logout(request)
    return redirect('user_login')

@login_required
def Welcome(request):
    # Fetch distinct payment plan names and a representative row per plan.
    # Limit to avoid excessive memory usage if the table is very large.
    distinct_plans = list(
        ProductDetail.objects.values('payment_plan')
        .annotate(latest_id=Max('id'))
        .order_by()
    )[:1000]

    reasons = Reason.objects.all()

    # Names and LLR mapping for the selected representative rows
    payment_plan_names = [row['payment_plan'] for row in distinct_plans]
    latest_ids = [row['latest_id'] for row in distinct_plans if row.get('latest_id')]
    payment_plan_llrs_qs = ProductDetail.objects.filter(id__in=latest_ids).values_list(
        'payment_plan', 'product_price_weighted_llr_200'
    )
    payment_plan_llrs = {name: float(llr) for name, llr in payment_plan_llrs_qs}

    return render(request, 'index.html', {
        'payment_plan_names': payment_plan_names,
        'reasons': reasons,
        'payment_plan_llrs': json.dumps(payment_plan_llrs)  # Convert Python dict to JSON string
    })
    
@login_required  
def Results(request):
    # Retrieve the features from the GET request

    cost_per_credit = float(request.GET.get('cost_per_credit', 0))
    deposit_to_price_ratio = float(request.GET.get('deposit_to_price_ratio', 0))
    loan_duration = float(request.GET.get('loan_duration', 0))
    deposit = float(request.GET.get('deposit', 0))
    price = float(request.GET.get('price', 0))
    payment_plan_name = request.GET.get('payment_plan_name', "")

    # Load the trained model
    model = joblib.load('./model/best_model.joblib')

    # Create a feature array with the input values in the same order as the training features
    features = [[cost_per_credit, deposit_to_price_ratio, loan_duration]]

    # Make predictions using the loaded model
    llr_prediction = model.predict(features)[0]

    # Get the associated ProductDetail instance
    try:
        product_detail = ProductDetail.objects.get(payment_plan=payment_plan_name)
    except MultipleObjectsReturned:
        product_detail = ProductDetail.objects.filter(payment_plan=payment_plan_name).first()

    llr_prediction = llr_prediction * 100
    current_llr = (product_detail.product_price_weighted_llr_200) * 100
    product_price = product_detail.product_price


    # Define the percentage threshold (3%)
    percentage_threshold = 3

    # Check if llr_prediction is greater than current_llr by 3%
    if  llr_prediction > (current_llr + percentage_threshold):
        llr_prediction_adjusted =  current_llr + 2
    # Check if llr_prediction is less than current_llr by 3%
    elif (llr_prediction + percentage_threshold) < current_llr:
        llr_prediction_adjusted = current_llr - 1
    else:
        llr_prediction_adjusted = llr_prediction

    # Check if the payment plan already exists in LLRPricingAssumption
    existing_plans = LLRPricingAssumption.objects.filter(payment_plan=product_detail)

    if existing_plans.exists():
        latest_instance = existing_plans.order_by('-instance_number').first()
        new_instance_number = latest_instance.instance_number + 1
    else:
        new_instance_number = 1

    # Include instance_number in the payment plan name
    payment_plan_with_instance = f"{payment_plan_name}_est_{new_instance_number}"

    llr_assumption = LLRPricingAssumption(
        payment_plan=product_detail,
        instance_number=new_instance_number,
        cost_per_credit=float(cost_per_credit),
        loan_duration=int(loan_duration),
        deposit=float(deposit),
        price=float(price),
        deposit_to_price_ratio=float(deposit_to_price_ratio),
        predicted_llr=float(llr_prediction_adjusted),
        created_by=request.user  # Set the logged-in user
    )
   

    llr_assumption.save()
    
        # Fetch reasons after performing the predictions and saving the LLRPricingAssumption
    reasons = Reason.objects.all()

    return render(request, 'index.html', {
        'result': llr_prediction_adjusted,
        'payment_plan': product_detail,
        'instance_number': new_instance_number,
        'payment_plan_with_instance': payment_plan_with_instance,
        'current_llr': current_llr,
        'reasons' : reasons,
        'product_price': product_price,
        'cost_per_credit': cost_per_credit,
        'loan_duration': loan_duration,
        'deposit': deposit,
        'price': price,
        'deposit_to_price_ratio': deposit_to_price_ratio,
        
   # Include old values from ProductDetail model
    'old_product_price': product_detail.product_price,
    'old_cost_per_credit': product_detail.cost_per_credit,
    'old_loan_duration': product_detail.loan_duration,
    'old_deposit': product_detail.deposit,
    'old_deposit_to_price_ratio': product_detail.deposit_to_price_ratio,
    })

def evaluate_model(model, X_test, y_test, X_train, y, df):
    # Heavy imports deferred to reduce memory/CPU during regular requests
    from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score  # type: ignore
    from sklearn.model_selection import learning_curve  # type: ignore
    import numpy as np  # type: ignore
    import matplotlib.pyplot as plt  # type: ignore
    import seaborn as sns  # type: ignore

    # Ensure Data Availability
    if X_train.empty or y.empty or X_test.empty or y_test.empty:
        print("One or more DataFrames are empty.")
        return None, None, None, None

    # Predict
    y_pred = model.predict(X_test)
    
    # Calculate RMSE, MAE, and R2
    rmse = sqrt(mean_squared_error(y_test, y_pred))
    mae = mean_absolute_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)
    
    # Calculate Residuals
    residuals = y_test - y_pred
    
    # Create Subplots Dynamically Based on Feature Count
    num_features = len(X_train.columns)
    max_feature_plots = min(num_features, 6)
    has_importances = hasattr(model, 'feature_importances_')
    total_rows = max_feature_plots + (6 if has_importances else 5)  # feature plots + (true-vs-pred, hist, [importances], heatmap, residual)
    fig_height = 2.8 * total_rows + 2
    fig, axes = plt.subplots(nrows=total_rows, ncols=1, figsize=(14, fig_height), constrained_layout=True)
    if total_rows == 1:
        axes = [axes]
    
    # Scatter plots for each feature vs Target Variable
    for i, feature in enumerate(X_train.columns[:max_feature_plots]):
        axes[i].scatter(X_test[feature], y_test, label='Actual', color='blue', alpha=0.6, s=20)
        axes[i].scatter(X_test[feature], y_pred, label='Predicted', color='green', alpha=0.6, s=20)
        axes[i].set_xlabel(feature, fontsize=12)
        axes[i].set_ylabel('Target', fontsize=12)
        axes[i].set_title(f'{feature} vs Target', fontsize=13)
        axes[i].grid(True, alpha=0.3)

    # Scatter plot: True vs Predicted values
    base_row = max_feature_plots
    axes[base_row].scatter(y_test, y_pred, s=20, alpha=0.6, color='green')
    axes[base_row].set_xlabel('True', fontsize=12)
    axes[base_row].set_ylabel('Predicted', fontsize=12)
    axes[base_row].set_title('True vs. Predicted', fontsize=13)
    axes[base_row].grid(True, alpha=0.3)

    # Histogram of residuals
    sns.histplot(residuals, kde=False, ax=axes[base_row + 1], bins=40)
    axes[base_row + 1].set_xlabel('Residuals', fontsize=12)
    axes[base_row + 1].set_ylabel('Freq', fontsize=12)
    axes[base_row + 1].set_title('Error Distribution', fontsize=13)

    # Feature importances (if the model has the attribute)
    if has_importances:
        importances = model.feature_importances_
        row_idx = base_row + 2
        axes[row_idx].barh(range(len(importances)), importances, height=0.6)
        axes[row_idx].set_yticks(range(len(importances)))
        axes[row_idx].set_yticklabels([X_train.columns[i] for i in range(len(importances))], fontsize=11)
        axes[row_idx].set_xlabel('Importance', fontsize=12)
        axes[row_idx].set_title('Feature Importances', fontsize=13)
        next_row = row_idx + 1
    else:
        next_row = base_row + 2

    # Create a subplot for the Learning Curves
    train_sizes, train_scores, validation_scores = learning_curve(model, X_train, y, train_sizes=np.linspace(.1, 1.0, 5)) # type: ignore
    axes[next_row].plot(train_sizes, train_scores.mean(axis=1), label='Train', linewidth=1.5)
    axes[next_row].plot(train_sizes, validation_scores.mean(axis=1), label='Validation', linewidth=1.5)
    axes[next_row].set_xlabel('Training size', fontsize=12)
    axes[next_row].set_ylabel('Score', fontsize=12)
    axes[next_row].set_title('Learning curves', fontsize=13)
    axes[next_row].legend(fontsize=10)
    next_row += 1

    # Create a subplot for the Correlation Heatmap
    correlation_matrix = df.corr(numeric_only=True)
    sns.heatmap(correlation_matrix, annot=False, ax=axes[next_row], cbar=True)
    axes[next_row].set_title('Correlation Heatmap', fontsize=13)
    axes[next_row].tick_params(axis='x', labelrotation=45, labelsize=10)
    axes[next_row].tick_params(axis='y', labelrotation=0, labelsize=10)
    next_row += 1

    # Create a subplot for the Residual Plot
    residuals = y_test - y_pred
    axes[next_row].scatter(y_pred, residuals, s=20, alpha=0.6)
    axes[next_row].set_xlabel('Predicted', fontsize=12)
    axes[next_row].set_ylabel('Residuals', fontsize=12)
    axes[next_row].set_title('Residual Plot', fontsize=13)

    try:
        image = io.BytesIO()
        plt.savefig(image, format='png', dpi=120)
        image.seek(0)
        graph_url = base64.b64encode(image.getvalue()).decode()
    except MemoryError:
        graph_url = None
    finally:
        plt.close(fig)
    
    return rmse, mae, r2, graph_url
@login_required  
@user_passes_test(is_superuser)
def Upload(request):
    # Heavy imports deferred to when upload endpoint is used
    import pandas as pd  # type: ignore
    from sklearn.model_selection import train_test_split  # type: ignore
    from sklearn.linear_model import LinearRegression, Ridge, Lasso, ElasticNet, BayesianRidge  # type: ignore
    from sklearn.tree import DecisionTreeRegressor  # type: ignore
    from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor  # type: ignore
    from sklearn.svm import SVR  # type: ignore
    from sklearn.neighbors import KNeighborsRegressor  # type: ignore
    from sklearn.pipeline import make_pipeline  # type: ignore
    from sklearn.preprocessing import PolynomialFeatures  # type: ignore
    from sklearn.neural_network import MLPRegressor  # type: ignore

    models = {
        'Linear Regression': LinearRegression(),
        'Ridge Regression': Ridge(),
        'Lasso Regression': Lasso(),
        'ElasticNet Regression': ElasticNet(),
        'Decision Tree': DecisionTreeRegressor(),
        'Random Forest': RandomForestRegressor(),
        'Gradient Boosting': GradientBoostingRegressor(),
        'Support Vector Machine': SVR(),
        'K-Nearest Neighbors': KNeighborsRegressor(),
        'Polynomial Regression': make_pipeline(PolynomialFeatures(degree=2), LinearRegression()),
        'Bayesian Regression': BayesianRidge(),
        'Neural Network Regression': MLPRegressor(hidden_layer_sizes=(100,), activation='relu', solver='adam', max_iter=1000)
    }

    if request.method == 'POST':
        csv_file = request.FILES['csv_file']
        if csv_file.name.endswith('.csv'):
            data_list = []
            data_list2 = []

            # Stream CSV rows to avoid loading entire file into memory
            MAX_ROWS = int(os.environ.get('UPLOAD_MAX_ROWS', '20000'))
            text_stream = io.TextIOWrapper(csv_file.file, encoding='utf-8', newline='')
            csv_data = csv.reader(text_stream, delimiter=',')
            try:
                header = next(csv_data)  # Skip header
            except StopIteration:
                return render(request, 'upload.html', {'error': 'Empty CSV file.'})

            processed = 0
            for row in csv_data:
                if not row:
                    continue
                # Defensive: ensure row has expected length
                while len(row) < 9:
                    row.append('')
                data_dict = {
                    'Cost per Credit': float(row[2].replace(',', '')) if row[2] else 0,
                    'Deposit': float(row[3].replace(',', '')) if row[3] else 0,
                    'Loan Duration': float(row[4].replace(',', '')) if row[4] else 0,
                    'Product Price': float(row[5].replace(',', '')) if row[5] else 0,
                    'Product Price Weighted Llr 200': float(row[6].replace(',', '')) if row[6] else 0,
                    'Quality of Sales': float(row[7].replace(',', '')) if row[7] else 0,
                    'Deposit to Price Ratio': float(row[8].replace(',', '')) if row[8] else 0
                }
                data_dict2 = {
                    'LoanId': row[0] if row[0] else 0,
                    'Payment Plan': row[1] if row[1] else 'Default Plan',
                    'Cost per Credit': float(row[2].replace(',', '')) if row[2] else 0,
                    'Deposit': float(row[3].replace(',', '')) if row[3] else 0,
                    'Loan Duration': float(row[4].replace(',', '')) if row[4] else 0,
                    'Product Price': float(row[5].replace(',', '')) if row[5] else 0,
                    'Product Price Weighted Llr 200': float(row[6].replace(',', '')) if row[6] else 0,
                    'Quality of Sales': float(row[7].replace(',', '')) if row[7] else 0,
                    'Deposit to Price Ratio': float(row[8].replace(',', '')) if row[8] else 0
                }
                data_list.append(data_dict)
                data_list2.append(data_dict2)
                processed += 1
                if processed >= MAX_ROWS:
                    break

            df = pd.DataFrame(data_list)
            df2 = pd.DataFrame(data_list2)

            # Bulk insert to reduce DB overhead
            objs = []
            for _, row in df2.iterrows():
                objs.append(ProductDetail(
                    loan_id=row['LoanId'],
                    payment_plan=row['Payment Plan'],
                    cost_per_credit=row['Cost per Credit'],
                    deposit=row['Deposit'],
                    loan_duration=int(row['Loan Duration']),
                    product_price=row['Product Price'],
                    product_price_weighted_llr_200=row['Product Price Weighted Llr 200'],
                    quality_of_sales=row['Quality of Sales'],
                    deposit_to_price_ratio=row['Deposit to Price Ratio']
                ))
            if objs:
                ProductDetail.objects.bulk_create(objs, batch_size=1000)

            X = df[['Cost per Credit', 'Deposit to Price Ratio', 'Loan Duration']]
            y = df['Product Price Weighted Llr 200']
            X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

            model_accuracies = []
            best_model = None
            model_best = None
            best_rmse = float('inf')
            best_mae = float('inf')
            best_r2 = -float('inf')
            best_graph_url = None

            for model_name, model in models.items():
                model.fit(X_train, y_train)
                rmse, mae, r2, graph_url = evaluate_model(model, X_test, y_test, X_train, y_train, df)
                model_accuracies.append((model_name, r2, mae, rmse))

                if rmse < best_rmse and mae < best_mae and r2 > best_r2:# type: ignore
                    best_model = model
                    model_best = model_name
                    best_rmse = rmse
                    best_mae = mae
                    best_r2 = r2
                    best_graph_url = graph_url

            model_path = os.path.join('model', 'best_model.joblib')
            joblib.dump(best_model, model_path)

            return render(request, 'message.html', {
                'model_accuracies': model_accuracies,
                'best_accuracy': best_r2,
                'best_rmse': best_rmse,
                'best_mae': best_mae,
                'best_model_name': model_best,
                'best_graph_url': best_graph_url
            })

    return render(request, 'upload.html')
@login_required
def save_sales_projection(request):
    try:
        product_detail_id = request.GET.get('product_detail_id')
        instance = request.GET.get('instance_number')

        # Filtering based on both payment_plan and instance_number
        product_detail = LLRPricingAssumption.objects.filter(
            payment_plan=product_detail_id,
            instance_number=instance
        ).first()

        if not product_detail:
            return HttpResponse('LLRPricingAssumption with given payment_plan and instance_number does not exist')

        # Update the LLRPricingAssumption fields
        product_detail.anticipated_growth = int(float(request.GET.get('anticipated_growth', 0.0)))
        product_detail.price_change = float(request.GET.get('price_change', 0.0))
        product_detail.total_volume_before = int(float(request.GET.get('total_volume_before', 0)))
        product_detail.total_volume_after = int(float(request.GET.get('total_volume_after', 0)))
        product_detail.unit_price_before = float(request.GET.get('unit_price_before', 0.0))
        product_detail.unit_price_after = float(request.GET.get('unit_price_after', 0.0))
        product_detail.gross_revenue_before = float(request.GET.get('gross_revenue_before', 0.0))
        product_detail.gross_revenue_after = float(request.GET.get('gross_revenue_after', 0.0))
        product_detail.current_priced_cm2_before = float(request.GET.get('current_priced_cm2_before', 0.0))
        product_detail.current_priced_cm2_after = float(request.GET.get('current_priced_cm2_after', 0.0))
        product_detail.expected_cm2_revenue_before = float(request.GET.get('expected_cm2_revenue_before', 0.0))
        product_detail.expected_cm2_revenue_after = float(request.GET.get('expected_cm2_revenue_after', 0.0))
        product_detail.current_llr = float(request.GET.get('current_llr', 0.0))
        product_detail.llr_threshold_zero_sum = float(request.GET.get('llr_threshold_zero_sum', 0.0))
        reason_id = request.GET.get('reason', '')
        reason_instance = get_object_or_404(Reason, id=reason_id)

        # Update the LLRPricingAssumption fields
        product_detail.reason = reason_instance
        product_detail.comment = request.GET.get('comment', '')

        # Retrieve the associated ProductDetail
        product_details = ProductDetail.objects.get(id=product_detail_id)
        payment_plan_name = product_details.payment_plan
        # Split the payment plan name into individual words
        payment_plan_words = payment_plan_name.split()
        number_of_words_to_extract = 3
                # Modified
        payment_plan_name_str = ' '.join(payment_plan_words[2:2 + number_of_words_to_extract])

        # Start with an empty Q object
        q = Q()

        # Add conditions for each word in payment plan name
        q |= Q(plan_name__icontains=payment_plan_name_str)

        # Retrieve all PaymentPlanProjections
        all_projections = PaymentPlanProjection.objects.all()

        # Filter projections based on the constructed Q object
        matching_projections = all_projections.filter(q)

        # Use the first matching projection, if any
        payment_plan_projection = matching_projections.first()

        if not payment_plan_projection:
            debug_message = (
                'No matching PaymentPlanProjection found for the given payment plan name\n'
                f"product_detail: {product_detail}\n"
                f"product_details: {product_details}\n"
                f"payment_projection:{payment_plan_projection}\n"
            )
            return HttpResponse(debug_message)

        # Extract data from the projections
        projections_data = payment_plan_projection.projections
        projection_date = datetime.strptime(projections_data[0]['date'], "%Y-%m")
        projection_amount = float(projections_data[0]['amount'])

        # Calculate remaining amount based on the current date
        today = datetime.today()
        _, last_day_of_month = calendar.monthrange(today.year, today.month)
        remaining_days = (projection_date + relativedelta(months=1, day=1)) - today
        remaining_amount_current_month = float((projection_amount / last_day_of_month)) * float(remaining_days.days)

        # Calculate total remaining amount by adding to the amounts of the remaining months
        total_remaining_amount = remaining_amount_current_month
        remaining_months = relativedelta(today, projection_date).months

       # Flag to indicate whether we're in the current month
        in_current_month = True
        added_amounts = []
        # Iterate through the projection data to add amounts of all months
        for month_data in projections_data[1:]:
            month_date = datetime.strptime(month_data['date'], "%Y-%m")
            added_amounts.append(float(month_data['amount']))
            total_remaining_amount += float(month_data['amount'])

            if in_current_month:
                # Check if we have moved to the next month
                if month_date > today:
                    in_current_month = False


               

        # Comparison and actions after the loop
        if total_remaining_amount > product_detail.total_volume_after:
            product_detail.save()
            success_message = (
    f'Congratulations, your estimates are successfully saved! '
    
)
            messages.success(request, success_message)
            return render(request, 'success.html')
        else:
            locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')
            product_detail.save()
            product_cost = float(payment_plan_projection.product_cost)
            difference = float(product_detail.total_volume_after - total_remaining_amount)
            difference_cost = difference * product_cost
            formatted_total_volume_after = locale.format_string("%.0f", product_detail.total_volume_after, grouping=True)
            formatted_difference = locale.format_string("%.0f", difference, grouping=True)
            formatted_difference_cost = locale.format_string("%.0f", difference_cost, grouping=True)
            error_message = (
                f"Your new expected volume {formatted_total_volume_after} is higher than the forecast by {formatted_difference}. "
                f"This means you will need more {formatted_difference_cost} "
              
            )
            return render(request, 'success.html', {'error_message': error_message})

    except ValueError as ve:
        return HttpResponse(f"Value Error: {str(ve)}")
    except TypeError as te:
        return HttpResponse(f"Type Error: {str(te)}")
    except Exception as e:
        return HttpResponse(f"An unknown error occurred: {str(e)}")

    # Fallback return statement
    return HttpResponse("Unhandled case or missing data.")
    
@login_required
def show_sales_list(request):
    data = LLRPricingAssumption.objects.all()

    # Process the data to include the percentage calculation
    for item in data:

        item.anticipated_growth_percentage = item.anticipated_growth / 100 if item.anticipated_growth else None
        item.price_change_percentage = item.price_change / 100 if item.price_change else None
        item.predicted_llr_percentage = item.predicted_llr / 100 if item.predicted_llr else None
        item.current_llr_percentage = item.current_llr / 100 if item.current_llr else None
        item.llr_threshold_zero_sum_percentage = item.llr_threshold_zero_sum / 100 if item.llr_threshold_zero_sum else None
        item.current_priced_cm2_after_p= item.current_priced_cm2_after / 100 if item.current_priced_cm2_after else None
        item.current_priced_cm2_before_p= item.current_priced_cm2_before / 100 if item.current_priced_cm2_before else None
        
     

    return render(request, 'show_sales_projection.html', {'data': data})
@login_required
def estimates(request):
    # Fetch all LLRPricingAssumption objects
    llr_assumptions = LLRPricingAssumption.objects.all()

    # Modify the payment plans to concatenate 'est' and instance_number
    payment_plans = [f"{assumption.payment_plan.payment_plan}_est_{assumption.instance_number}" for assumption in llr_assumptions]

    selected_plan = request.GET.get('payment_plan_name')
    llr_details = None
    percentage_difference = None  # Initialize the percentage difference variable
    additional_loss = None
    error_message = None  # Initialize the error message

    if selected_plan:
        # Split the selected plan to extract the original payment plan name and instance number
        split_parts = selected_plan.split('_est_')
        if len(split_parts) == 2:
            payment_plan_name, instance_number = split_parts
            instance_number = int(instance_number)  # Convert instance_number to integer
            product_detail_instance = ProductDetail.objects.filter(payment_plan=payment_plan_name).first()
            old_product_detail = ProductDetail.objects.filter(payment_plan=payment_plan_name).first()
            # Use the instance number in filtering the LLRPricingAssumption objects
            if product_detail_instance:
                llr_details = LLRPricingAssumption.objects.filter(payment_plan=product_detail_instance, instance_number=instance_number)

                # Calculate the percentage difference
                if llr_details and llr_details[0].gross_revenue_after is not None:
                    predicted_llr = llr_details[0].predicted_llr or Decimal('0.0')  # Set to 0 if predicted_llr is None
                    llr_threshold_zero_sum = llr_details[0].llr_threshold_zero_sum or Decimal('0.0')  # Set to 0 if llr_threshold_zero_sum is None

                    if predicted_llr is not None and llr_threshold_zero_sum is not None:
                        # Calculate the percentage difference
                        percentage_difference = float(predicted_llr - llr_threshold_zero_sum)
                        # Calculate the additional loss
                        additional_loss = round((float(llr_details[0].gross_revenue_after) * percentage_difference) / 100, 2)
                    else:
                        # Handle the case where predicted_llr or llr_threshold_zero_sum is None
                        additional_loss = 0.0
                else:
                    # Handle the case where llr_details is empty or gross_revenue_after is None
                    additional_loss = 0.0


               # Split the selected plan using a regular expression to capture alphanumeric and special characters
                payment_plan_words = re.findall(r'\S+', selected_plan)
                number_of_words_to_extract = 3
                # Modified
                payment_plan_name_str = ' '.join(payment_plan_words[2:2 + number_of_words_to_extract])
              

# Start with an empty Q object

                q = Q()
                q |= Q(plan_name__icontains=payment_plan_name_str)


# Retrieve all PaymentPlanProjections
                all_projections = PaymentPlanProjection.objects.all()

# Filter projections based on the constructed Q object
                matching_projections = all_projections.filter(q)
                if not matching_projections:
                  debug_message = (
                'No matching Projection found for the given payment plan name\n'
                f"payment_plan_name: {selected_plan}\n{payment_plan_words}"
            )
                  return HttpResponse(debug_message)

        # Extract data from the most recent projection
                projection = matching_projections.first()
                projections_data = projection.projections
                projection_date = datetime.strptime(projections_data[0]['date'], "%Y-%m")
                projection_amount = float(projections_data[0]['amount'])

        # Calculate remaining amount based on the current date
                today = datetime.today()
                _, last_day_of_month = calendar.monthrange(today.year, today.month)
                remaining_days = (projection_date + relativedelta(months=1, day=1)) - today
                remaining_amount_current_month = float((projection_amount / last_day_of_month)) * float(remaining_days.days)

        # Calculate total remaining amount by adding to the amounts of the remaining months
                total_remaining_amount = remaining_amount_current_month
                remaining_months = relativedelta(today, projection_date).months

       # Flag to indicate whether we're in the current month
                in_current_month = True
                added_amounts = []
        # Iterate through the projection data to add amounts of all months
                for month_data in projections_data[1:]:
                   month_date = datetime.strptime(month_data['date'], "%Y-%m")
                   added_amounts.append(float(month_data['amount']))
                   total_remaining_amount += float(month_data['amount'])

                if in_current_month:
                # Check if we have moved to the next month
                   if month_date > today:
                     in_current_month = False
        # Check if total_volume_after is higher than total_remaining_amount
                #product_detail = ProductDetail.objects.get(id=llr_details[0].payment_plan)  # You may need to retrieve this id somehow
                if llr_details and llr_details[0].total_volume_after is not None and total_remaining_amount is not None:
                   if llr_details and llr_details[0].total_volume_after > total_remaining_amount:
                        locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')
                        difference = float(llr_details[0].total_volume_after - total_remaining_amount)
                        product_cost = float(projection.product_cost)
                        difference_cost = difference * product_cost
                        formatted_total_volume_after = locale.format_string("%.0f", llr_details[0].total_volume_after, grouping=True)
                        formatted_difference = locale.format_string("%.0f", difference, grouping=True)
                        formatted_difference_cost = locale.format_string("%.0f", difference_cost, grouping=True)
                        error_message = (
    f"Your new expected volume {formatted_total_volume_after} is higher than the forecast by {formatted_difference}. "
    f"This means you will need more {formatted_difference_cost} forecast."
)
                return render(request, 'estimate.html', {
        'payment_plans': payment_plans,
        'llr_details': llr_details,
        'percentage_difference': percentage_difference,
        'additional_loss': additional_loss,
        'error_message': error_message,  # Include the error message
          'old_product_detail': old_product_detail,
    })
                
    return render(request, 'estimate.html', {
        'payment_plans': payment_plans,
        'llr_details': llr_details,
        'percentage_difference': percentage_difference,
        'additional_loss': additional_loss,
        # No error message when the condition is not met
        'old_product_detail': old_product_detail,
    })            
    
@login_required  
@user_passes_test(is_superuser)    
def add_payment_projection(request):
    if request.method == "POST":
        # Read JSON data from the request body
        data = json.loads(request.body.decode('utf-8'))

        plan_name = data.get('plan_name')
        product_cost = data.get('product_cost')
        projections = data.get('projections', [])

        # Create a PaymentPlanProjection instance
        payment_projection = PaymentPlanProjection(
            product_cost=product_cost,
            plan_name=plan_name,
            projections=projections
        )
        payment_projection.save()

        return JsonResponse({'status': 'success', 'message': 'Forecast added successfully'})

    return render(request, 'add_payment_projection.html')
@login_required 
@user_passes_test(is_superuser) 
def list_payment_projections(request):
    projections = PaymentPlanProjection.objects.all()
    return render(request, 'list_payment_projections.html', {'projections': projections})


@login_required  
@user_passes_test(is_superuser)
def edit_payment_projection(request, pk):
    payment_projection = get_object_or_404(PaymentPlanProjection, pk=pk)

    if request.method == "POST":
        try:
            # Decode JSON data from the request body
            data = json.loads(request.body.decode('utf-8'))

            # Extract data from the decoded JSON data
            plan_name = data.get('plan_name')
            product_cost = data.get('product_cost')
            projections = data.get('projections', [])

            # Update the PaymentPlanProjection instance with the new data
            payment_projection.plan_name = plan_name
            payment_projection.product_cost = product_cost
            payment_projection.projections = projections

            payment_projection.save()
            return JsonResponse({'status': 'success', 'message': 'Forecast updated successfully'})

        except json.JSONDecodeError as e:
            # Handle JSON decoding error
            return JsonResponse({'error': 'Invalid JSON format'}, status=400)

        except Exception as e:
            # Handle other exceptions
            return JsonResponse({'error': str(e)}, status=500)

    return render(request, 'edit_payment_projection.html', {'payment_projection': payment_projection})
@login_required  
@user_passes_test(is_superuser)
def delete_payment_projection(request, pk):
    payment_projection = get_object_or_404(PaymentPlanProjection, pk=pk)

    if request.method == "POST":
        payment_projection.delete()
        return redirect('list_payment_projections')

    return render(request, 'delete_payment_projection.html', {'payment_projection': payment_projection})    

@login_required  
@user_passes_test(is_superuser)
def reason_list(request):
    reasons = Reason.objects.all()
    return render(request, 'reason_list.html', {'reasons': reasons})

@login_required  
@user_passes_test(is_superuser)
def reason_add(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        if name:
            Reason.objects.create(name=name)
            return redirect('reason_list')

    return render(request, 'reason_form.html', {'action': 'Add'})

@login_required  
@user_passes_test(is_superuser)
def reason_edit(request, pk):
    reason = get_object_or_404(Reason, pk=pk)

    if request.method == 'POST':
        name = request.POST.get('name')
        if name:
            reason.name = name
            reason.save()
            return redirect('reason_list')

    return render(request, 'reason_form.html', {'reason': reason, 'action': 'Edit'})

@login_required  
@user_passes_test(is_superuser)
def reason_delete(request, pk):
    reason = get_object_or_404(Reason, pk=pk)

    if request.method == 'POST':
        reason.delete()
        return redirect('reason_list')

    return render(request, 'reasons/reason_confirm_delete.html', {'reason': reason})


@login_required
def export_to_excel(request):
    response = HttpResponse(content_type='application/vnd.ms-excel')
    response['Content-Disposition'] = f'attachment; filename=sales_data_{timezone.now().strftime("%Y%m%d%H%M%S")}.xls'

    wb = xlwt.Workbook(encoding='utf-8')
    ws = wb.add_sheet('Sales Data')

    # Write headers
    headers = [
        'Product Detail','Cost Per Credit' ,'New Cost Per Credit','Loan Duration', 'New Loan Duration', 
        'Deposit','New Deposit','Product Price' ,'New Product Price','Deposit to Price Ration',
          'New Deposit to Price Ratio','Anticipated Growth ', 'Price Change ',
        'Total Volume Before', 'Total Volume After', 'Unit Price Before',
        'Unit Price After', 'Gross Revenue Before', 'Gross Revenue After',
        'Current Priced CM2 Before', 'Current Priced CM2 After',
        'Expected CM2 Revenue Before', 'Expected CM2 Revenue After',
        'Current LLR', 'Estimated LLR', 'LLR Threshold Zero Sum', 
        'Reason', 'Comment',  'Added by', 'Date'
    ]

    for col_num, header in enumerate(headers):
        ws.write(0, col_num, header)

    # Write data
    data = LLRPricingAssumption.objects.all()
    for row_num, item in enumerate(data, start=1):
        # Calculate percentages
        anticipated_growth_percentage = item.anticipated_growth / 100 if item.anticipated_growth else None
        price_change_percentage = item.price_change / 100 if item.price_change else None
        predicted_llr_percentage = item.predicted_llr / 100 if item.predicted_llr else None
        current_llr_percentage = item.current_llr / 100 if item.current_llr else None
        llr_threshold_zero_sum_percentage = item.llr_threshold_zero_sum / 100 if item.llr_threshold_zero_sum else None
        current_priced_cm2_after_p = item.current_priced_cm2_after / 100 if item.current_priced_cm2_after else None
        current_priced_cm2_before_p = item.current_priced_cm2_before / 100 if item.current_priced_cm2_before else None
        ws.write(row_num, 0, str(item.payment_plan))
        ws.write(row_num, 1, item.payment_plan.cost_per_credit)
        ws.write(row_num, 2, item.cost_per_credit)
        ws.write(row_num, 3, item.payment_plan.loan_duration)
        ws.write(row_num, 4, item.loan_duration)
        ws.write(row_num, 5, item.payment_plan.deposit)
        ws.write(row_num, 6, item.deposit)
        ws.write(row_num, 7, item.payment_plan.product_price)
        ws.write(row_num, 8, item.price)
        ws.write(row_num, 9, item.payment_plan.deposit_to_price_ratio)
        ws.write(row_num, 10, item.deposit_to_price_ratio)
        ws.write(row_num, 11, anticipated_growth_percentage)
        ws.write(row_num, 12, price_change_percentage)
        ws.write(row_num, 13, item.total_volume_before)
        ws.write(row_num, 14, item.total_volume_after)
        ws.write(row_num, 15, item.unit_price_before)
        ws.write(row_num, 16, item.unit_price_after)
        ws.write(row_num, 17, item.gross_revenue_before)
        ws.write(row_num, 18, item.gross_revenue_after)
        ws.write(row_num, 19, current_priced_cm2_before_p)
        ws.write(row_num, 20, current_priced_cm2_after_p)
        ws.write(row_num, 21, item.expected_cm2_revenue_before)
        ws.write(row_num, 22, item.expected_cm2_revenue_after)
        ws.write(row_num, 23, current_llr_percentage)
        ws.write(row_num, 24, predicted_llr_percentage)
        ws.write(row_num, 25, llr_threshold_zero_sum_percentage)
        ws.write(row_num, 26, str(item.reason))
        ws.write(row_num, 27, str(item.comment))
        ws.write(row_num, 28, f"{item.created_by.first_name} {item.created_by.last_name}")

        ws.write(row_num, 29, item.created_date.strftime('%Y-%m-%d'))

    wb.save(response)

    previous_url = request.META.get('HTTP_REFERER', None)
    if previous_url:
        return response
    else:
        return HttpResponse("Exported successfully, but couldn't determine the previous page.")