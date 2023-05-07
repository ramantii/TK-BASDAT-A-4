from django.urls import path
from panitia.views import show_panitia

app_name = 'panitia'

urlpatterns = [
    path('', show_panitia, name='show_panitia'),   

]