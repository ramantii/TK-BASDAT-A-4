# urls.py for penonton app
# Compare this snippet from penonton\urls.py:
from django.urls import path

from . import views
app_name = 'penonton'

urlpatterns = [
    path('', views.dashboard, name = 'dashboard'),
]