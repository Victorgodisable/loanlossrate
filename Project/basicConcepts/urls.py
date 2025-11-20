from django.urls import path
from . import views
urlpatterns = [
    path('', views.user_login, name='user_login'),
    path('home', views.Welcome, name='index'),
    path('result', views.Results, name='result'),
    path('upload',views.Upload, name='upload'),
    path('save_sales_projection/', views.save_sales_projection, name='save_sales_projection'),
    path('show_sales_list/', views.show_sales_list, name='show_sales_list'),
path('estimate/', views.estimates, name='estimates'),
path('add-projection/', views.add_payment_projection, name='add_payment_projection'),
    path('<int:pk>/edit/', views.edit_payment_projection, name='edit_payment_projection'),
    path('<int:pk>/delete/', views.delete_payment_projection, name='delete_payment_projection'),
path('list-payment-projections/',views.list_payment_projections, name='list_payment_projections'),
path('list/', views.reason_list, name='reason_list'),
    path('add/', views.reason_add, name='reason_add'),
    path('edit/<int:pk>/', views.reason_edit, name='reason_edit'),
    path('delete/<int:pk>/', views.reason_delete, name='reason_delete'),
     path('logout/', views.logout_view, name='logout'),
     path('export-to-excel/', views.export_to_excel, name='export_to_excel'),

]

