from django.urls import path

from . import views
app_name = 'authentication'

urlpatterns = [
    path('', views.landing_page, name = 'landing_page'),
    path('login/', views.login, name = 'login'),
    path('register/', views.register, name = 'register'),
    # path register/manajer
    path('register/manajer/', views.show_register_manajer, name = 'register_manajer'),
    # path register/panitia
    path('register/panitia/', views.show_register_panitia, name = 'register_panitia'),
    # path register/penonton
    path('register/penonton/', views.show_register_penonton, name = 'register_penonton'),
    # path to register/manajer/submit
    path('register/manajer/submit', views.register_submit, name = 'register_manajer_submit'),
    # path to register/penonton/submit
    path('register/penonton/submit', views.register_submit, name = 'register_penonton_submit'),
    # path to register/panitia/submit
    path('register/panitia/submit', views.register_submit, name = 'register_panitia_submit'),
    # path to logout
    path('logout/', views.logout, name = 'logout'),


]