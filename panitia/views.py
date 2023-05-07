from django.shortcuts import render

# Create your views here.
def show_manage(request):
    context = {
        "sisa_waktu": 600
    }
    return render(request, "managePertandingan.html", context)

def show_buat_pertandingan(request):
    context = {
        "sisa_waktu": 600
    }
    return render(request, "buatPertandingan.html", context)

def show_mulai_pertandingan(request):
    context = {
        "sisa_waktu": 600
    }
    return render(request, "mulaiPertandingan.html", context)

def show_mulai_rapat(request):
    context = {
        "sisa_waktu": 600
    }
    return render(request, "mulaiRapat.html", context)

def show_lihat_peristiwa(request):
    context = {
        "sisa_waktu": 600
    }
    return render(request, "lihatPeristiwa.html", context)

def show_list_pertandingan(request):
    context = {
        "sisa_waktu": 600
    }
    return render(request, "listPertandingan.html", context)

def show_pembuatan_pertaandingan(request):
    context = {
        "sisa_waktu": 600
    }
    return render(request, "pembuatanPertandingan.html", context)

def show_list_waktu_stadium(request):
    context = {
        "sisa_waktu": 600
    }
    return render(request, "listWaktuStadium.html", context)

def show_rapat_pertandingan(request):
    context = {
        "sisa_waktu": 600
    }
    return render(request, "rapatPertandingan.html", context)

def show_buat_peristiwa(request):
    context = {
        "sisa_waktu": 600
    }
    return render(request, "buatPeristiwa.html", context)