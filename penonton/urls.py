# urls.py for penonton app
# Compare this snippet from penonton\urls.py:
from django.urls import path
from .views import *
from . import views
app_name = 'penonton'

urlpatterns = [
    path('', views.dashboard, name = 'dashboard'),
    path('tiket/list_stad', get_beli_list_stadium, name="get_beli_list_stadium"),
    path('tiket/list_wak', get_beli_list_waktu, name="get_beli_list_waktu"),
    path('tiket/list_pert', get_list_pertandingan, name="get_list_pertandingan"),
    path('tiket/beliticket', beli_ticket, name="beli_ticket"),
]