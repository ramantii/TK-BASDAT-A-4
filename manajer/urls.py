# urls.py for the manajer app
# Compare this snippet from manajer\urls.py:
from django.urls import path

from . import views
app_name = 'manajer'

urlpatterns = [
    path('', views.dashboard, name = 'dashboard'),
    path('tim/', views.show_tim, name = 'tim'),
    path('tim/make_captain/', views.make_captain, name = 'make_captain'),
    # path to delete pemain
    path('tim/delete_pemain/', views.delete_pemain, name = 'delete_pemain'),
    # path to delete pelatih
    path('tim/delete_pelatih/', views.delete_pelatih, name = 'delete_pelatih'),
    # path to add pemain
    path('tim/add_pemain/', views.add_pemain, name = 'add_pemain'),
    # path to add pelatih
    path('tim/add_pelatih/', views.add_pelatih, name = 'add_pelatih'),
    # path to create tim
    path('tim/create/', views.create_tim, name = 'create_tim'),
]
