from django.shortcuts import render, redirect
from utils.query import query

# Create your views here.
def dashboard(request):
    if (request.session.get('username') == None):
        return redirect('/login/')
    if (request.session.get('role') != 'panitia'):
        if (request.session.get('role') == None):
            return redirect('/')
        return redirect(f'/{request.session.get("role")}')
    
    non_pemain = query(f''' 
        SELECT nama_depan, nama_belakang, nomor_hp, email, alamat, string_agg(status, ', ') as status, jabatan
        FROM NON_PEMAIN np join status_non_pemain snp 
        on np.id = snp.id_non_pemain 
        join panitia p on p.id_panitia = np.id
        WHERE username = '{request.session.get("username")}'
        GROUP BY nama_depan, nama_belakang, nomor_hp, email, alamat, jabatan;
        ''')
    list_rapat = query(f'''
SELECT r.id_pertandingan, t.nama_tim as tim_a, t2.nama_tim as tim_b,  r.datetime, np1.nama_depan AS p_fname,
        np1.nama_belakang AS p_lname,
        np2.nama_depan AS ma_fname, np2.nama_belakang AS ma_lname,
        np3.nama_depan AS mb_fname, np3.nama_belakang AS mb_lname, r.isi_rapat
        FROM rapat r
        INNER JOIN non_pemain np1 ON np1.id = r.perwakilan_panitia
        INNER JOIN non_pemain np2 ON np2.id = r.manajer_tim_a
        INNER JOIN non_pemain np3 ON np3.id = r.manajer_tim_b
		INNER JOIN tim_manajer t on np2.id = t.id_manajer
		INNER JOIN tim_manajer t2 on np3.id = t2.id_manajer
        WHERE r.datetime > current_timestamp and
        r.perwakilan_panitia = (SELECT id FROM non_pemain WHERE username = '{request.session.get("username")}')
        ''')
    context = {
        "non_pemain": non_pemain,
        "list_rapat": list_rapat
        }   
    
    return render(request, 'dashboard_panitia.html', context)

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