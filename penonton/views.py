from django.shortcuts import render, redirect, HttpResponse
# import utils
from utils.query import query
import string
import random

forms = {}
# Create your views here.
def dashboard(request):
    if (request.session.get('username') == None):
        return redirect('/login/')
    if (request.session.get('role') != 'penonton'):
        if (request.session.get('role') == None):
            return redirect('/')
        return redirect(f'/{request.session.get("role")}')

    id = query(f''' SELECT id_penonton FROM PENONTON WHERE username = '{request.session.get("username")}' ''')[0]['id_penonton']
    non_pemain = query(f''' 
        SELECT nama_depan, nama_belakang, nomor_hp, email, alamat, string_agg(status, ', ') as status
        FROM NON_PEMAIN np join status_non_pemain snp 
        on np.id = snp.id_non_pemain 
        WHERE id = '{id}'
        GROUP BY nama_depan, nama_belakang, nomor_hp, email, alamat;
        ''')
    pemesanan_tiket = query(f''' 
        SELECT p.ID_Pertandingan, p.Start_Datetime, p.End_Datetime, s.Nama as nama_stadium, string_agg(tb.nama_tim, ' vs. ') as nama_tim, pt.jenis_tiket
        FROM Pembelian_Tiket AS pt INNER JOIN Pertandingan AS p ON 
        pt.id_pertandingan = p.ID_Pertandingan INNER JOIN Stadium AS s ON 
        p.Stadium = s.ID_Stadium 
        join tim_pertandingan tb on tb.id_pertandingan = p.id_pertandingan
        WHERE pt.id_penonton = '{id}' AND
        p.Start_Datetime > NOW()
        GROUP BY p.ID_Pertandingan, p.Start_Datetime, p.End_Datetime, nama_stadium, pt.jenis_tiket
    ''')

    # query select from status_non_pemain

    context = {
        'non_pemain': non_pemain,
        'list_pemesanan_tiket': pemesanan_tiket
        }
    return render(request, 'dashboard_penonton.html', context)

def get_beli_list_stadium(request):
    result = query(f"SELECT * FROM stadium")
    context = {'stadiums': result}

    if request.method != "POST":
        return render(request, "pembeliantiket.html", context)
    else:
        context = {"isNotValid": False, "message": "Harap masukkan seluruh data"}

        stadium = request.POST["stadium"]
        tanggal = request.POST["date"]  # Update the name of the date field

        context["isNotValid"] = not stadium or not tanggal
        print(context["isNotValid"])

        if context["isNotValid"]:
            context["stadiums"] = result
            return render(request, "pembeliantiket.html", context)

        forms['stadium'] = stadium
        forms['tanggal'] = tanggal

        return redirect("/penonton/tiket/list_wak")
    
def get_beli_list_waktu(request):
    result = query(f""" 
            SELECT concat(TO_CHAR(start_datetime,'HH:MI'), ' - ', TO_CHAR(end_datetime,'HH:MI')) as display, P.start_datetime::text FROM STADIUM S JOIN PERTANDINGAN 
            ON S.id_stadium = PERTANDINGAN.stadium 
            WHERE PERTANDINGAN.stadium = '{forms['stadium']}'
            AND start_datetime::timestamp::date = '{forms['tanggal']}'
            """)
    print(result)

    nama_stadium = query(
        f"SELECT nama FROM STADIUM WHERE id_stadium = '{forms['stadium']}'")[0][0]
    context = {"list_waktu": result, "nama_stadium": nama_stadium}

    if request.method != "POST":
        return render(request, "listpertandinganbeli.html", context)
    else:
        waktu = request.POST['waktu']
        forms['waktu'] = waktu

    return redirect("/penonton/tiket/list_pert")
def get_list_pertandingan(request):
    result = query(f"""
            SELECT DISTINCT ON (PERTANDINGAN.id_pertandingan) PERTANDINGAN.id_pertandingan, A.nama_tim as tim_a, B.nama_tim as tim_b
            FROM PERTANDINGAN , TIM_PERTANDINGAN A, TIM_PERTANDINGAN B, STADIUM 
            WHERE PERTANDINGAN.id_pertandingan = A.id_pertandingan
            AND PERTANDINGAN.id_pertandingan = B.id_pertandingan
            AND STADIUM.id_stadium = PERTANDINGAN.stadium
            AND A.nama_tim != B.nama_tim
            AND PERTANDINGAN.stadium = '{forms['stadium']}'
            AND PERTANDINGAN.start_datetime = '{forms['waktu']}'
            GROUP BY PERTANDINGAN.id_pertandingan, A.nama_tim, B.nama_tim;
            """)
    print(result)
    context = {"list_pertandingan": result}

    if request.method != "POST":
        return render(request, "listpertandinganbeli.html", context)
    else:
        pertandingan = request.POST['pertandingan']
        forms['pertandingan'] = pertandingan
    
        return redirect("/penonton/tiket/beliticket")
    
def beli_ticket(request):
    tipe_list = ["VIP", "Main East", "kategori 1", "kategori 2"]
    list_pembayaran = ['Mobile Banking', 'Gopay', 'OVO', 'Debit']
    context = {
        'tipe_list': tipe_list,
        'list_pembayaran': list_pembayaran,
        'isNotValid': False
    }

    if request.method != "POST":
        return render(request, "beliticket.html", context)
    else:
        jenis = request.POST['jenis']
        pembayaran = request.POST['pembayaran']

        lists = {}

        username = request.COOKIES['username']
        letters = string.ascii_uppercase
        lists['id_penonton'] = query(
            f"SELECT id_penonton FROM PENONTON WHERE username = '{username}'")[0][0]
        print(lists['id_penonton'])
        lists['pertandingan'] = forms["pertandingan"]
        lists['jenis'] = jenis
        lists['pembayaran'] = pembayaran
    

        result = query(f"""INSERT INTO PEMBELIAN_TIKET VALUES 
            ('{lists['receipt']}', '{lists['id_penonton']}', '{lists['jenis']}', '{lists['pembayaran']}', '{lists['pertandingan']}') """)

        if isinstance(result, Exception):
            context['message'] = str(result).partition('CONTEXT')[0]
            context["isNotValid"] = True
            return render(request, "beliticket.html", context)

        return redirect("/authentication/dashboard_penonton")
