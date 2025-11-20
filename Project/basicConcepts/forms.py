from django import forms
from .models import PaymentPlanProjection

class PaymentPlanProjectionForm(forms.ModelForm):
    class Meta:
        model = PaymentPlanProjection
        fields = ['plan_name', 'date', 'product_cost', 'projection_amount']

    def __init__(self, *args, **kwargs):
        super(PaymentPlanProjectionForm, self).__init__(*args, **kwargs)
        # You can add additional customization here if needed
        
# users/forms.py



class LoginForm(forms.Form):
    username = forms.CharField(max_length=50)
    password = forms.CharField(widget=forms.PasswordInput)
        