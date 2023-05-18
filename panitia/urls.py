from django.urls import path
from panitia.views import *

app_name = 'panitia'

urlpatterns = [
    path('', dashboard, name='panitia'),  
    path('manage', show_manage, name='manage'),
    path('buat_pertandingan', show_buat_pertandingan, name='buat_pertandingan'),
    path('mulai_pertandingan', show_mulai_pertandingan, name='mulai_pertandingan'),
    path('mulai_rapat', show_mulai_rapat, name='mulai_rapat'), 
    path('lihat_peristiwa', show_lihat_peristiwa, name='lihat_peristiwa'),
    path('list_pertandingan', show_list_pertandingan, name='list_pertandingan'),
    path('pembuatan_pertandingan', show_pembuatan_pertaandingan, name='pembuatan_pertandingan'),
    path('list_waktu_stadium', show_list_waktu_stadium, name='list_waktu_stadium'),
    path('rapat_pertandingan', show_rapat_pertandingan, name='rapat_pertandingan'),
    path('buat_peristiwa', show_buat_peristiwa, name='buat_peristiwa'),
]