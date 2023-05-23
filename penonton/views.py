from django.shortcuts import render, redirect, HttpResponse
# import utils
from utils.query import query

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