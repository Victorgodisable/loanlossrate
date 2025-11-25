from django.urls import path
from . import views
urlpatterns = [
    path('', views.user_login, name='user_login'),  #shows the login page.
    path('home', views.Welcome, name='index'),      #shows the welcome/home page.
    path('result', views.Results, name='result'),   #displays prediction results.
    path('upload',views.Upload, name='upload'),     #allows file uploads.
    path('save_sales_projection/', views.save_sales_projection, name='save_sales_projection'), #Saves a new sales projection.
    path('show_sales_list/', views.show_sales_list, name='show_sales_list'),  #Displays a list of saved sales projections.
path('estimate/', views.estimates, name='estimates'),  #Runs loan loss rate estimation.
path('add-projection/', views.add_payment_projection, name='add_payment_projection'), #Adds a new payment projection.
    path('<int:pk>/edit/', views.edit_payment_projection, name='edit_payment_projection'), #Edit a projection by primary key (ID).
    path('<int:pk>/delete/', views.delete_payment_projection, name='delete_payment_projection'), #Delete a projection by ID.
path('list-payment-projections/',views.list_payment_projections, name='list_payment_projections'), #List all payment projections.
path('list/', views.reason_list, name='reason_list'), #Show reasons list.
    path('add/', views.reason_add, name='reason_add'),  #Add a new reason.
    path('edit/<int:pk>/', views.reason_edit, name='reason_edit'), #Edit a reason by ID.
    path('delete/<int:pk>/', views.reason_delete, name='reason_delete'), #Delete a reason by ID
     path('logout/', views.logout_view, name='logout'), #Logs the user out.
     path('export-to-excel/', views.export_to_excel, name='export_to_excel'), #Exports data to Excel format.

]

