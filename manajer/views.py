from django.shortcuts import render, redirect, HttpResponse
# import utils
from utils.query import query

# Create your views here.

# show dashboard.html
def dashboard(request):
    if (request.session.get('username') == None):
        return redirect('/login/')
    if (request.session.get('role') != 'manajer'):
        if (request.session.get('role') == None):
            return redirect('/')
        return redirect(f'/{request.session.get("role")}')

    id = query(f''' SELECT id_manajer FROM MANAJER WHERE username = '{request.session.get("username")}' ''')[0]['id_manajer']
    non_pemain = query(f''' 
        SELECT nama_depan, nama_belakang, nomor_hp, email, alamat, string_agg(status, ', ') as status
        FROM NON_PEMAIN np join status_non_pemain snp 
        on np.id = snp.id_non_pemain 
        WHERE id = '{id}'
        GROUP BY nama_depan, nama_belakang, nomor_hp, email, alamat;
        ''')[0]
    # query select from status_non_pemain

    context = {
        'nama_depan': non_pemain["nama_depan"],
        'nama_belakang': non_pemain["nama_belakang"],
        'no_hp': non_pemain["nomor_hp"],
        'email': non_pemain["email"],
        'alamat': non_pemain["alamat"],
        'status': non_pemain["status"],
        }
    
    nama_tim = query(f''' SELECT nama_tim FROM TIM_MANAJER WHERE id_manajer = '{id}' ''')

    if len(nama_tim) != 0:
        tim = nama_tim[0]['nama_tim']
        universitas = query(f''' SELECT universitas FROM TIM WHERE nama_tim = '{tim}' ''')[0]['universitas']
        context['tim'] = tim
        request.session['nama_tim'] = tim
        context['universitas'] = universitas
        context['list_pemain'] = get_pemain(tim)
        context['list_pelatih'] = get_pelatih(tim)
    else:
        context['message'] = 'Anda belum membuat tim'	

    return render(request, 'dashboard.html', context)

def show_tim(request):
    if (request.session.get('username') == None):
        return redirect('/login/')
    
    if (request.session.get('role') != 'manajer'):
        if (request.session.get('role') == None):
            return redirect('/')
        return redirect(f'/{request.session.get("role")}')
    nama_tim = request.session.get('nama_tim')
    # print(nama_tim)
    if nama_tim == None:
        return render(request, 'form_pendaftaran_tim.html')

    context = {'list_pemain': get_pemain(nama_tim),
                'list_pelatih' : get_pelatih(nama_tim)}
    return render(request, 'tim.html', context)

def get_pemain(nama_tim):
    response = query(f'''
        SELECT * FROM PEMAIN 
        WHERE nama_tim = '{nama_tim}' 
        ORDER BY is_captain DESC
        ''')
    return response

def get_pelatih(nama_tim):
    response = query(f'''
        SELECT id, nama_depan, nama_belakang, nomor_hp,email, alamat, string_agg(spesialisasi, ', ') as spesialisasi
        FROM NON_PEMAIN NP INNER JOIN SPESIALISASI_PELATIH SP on NP.id = SP.id_pelatih
        WHERE NP.id in (
        SELECT id_pelatih from pelatih
        where nama_tim = '{nama_tim}'
        )
        GROUP BY id, nama_depan, nama_belakang, nomor_hp,email, alamat
        ''')
    return response

def make_captain(request):
    if (request.session.get('username') == None):
        return redirect('/login/')
    if (request.session.get('role') != 'manajer'):
        if (request.session.get('role') == None):
            return redirect('/')
        return redirect(f'/{request.session.get("role")}')
    if (request.session.get('nama_tim') == None):
        return redirect('/manajer/tim/')
    id_pemain = request.POST.get('id')
    print(query(f''' UPDATE PEMAIN SET is_captain = true WHERE id_pemain = '{id_pemain}' '''))
    
    return redirect('/manajer/tim/')

def delete_pemain(request):
    if (request.session.get('username') == None):
        return redirect('/login/')
    if (request.session.get('role') != 'manajer'):
        if (request.session.get('role') == None):
            return redirect('/')
        return redirect(f'/{request.session.get("role")}')
    if (request.session.get('nama_tim') == None):
        return redirect('/manajer/tim/')
    id_pemain = request.POST.get('id')
    print(query(f''' UPDATE PEMAIN SET nama_tim = NULL WHERE id_pemain = '{id_pemain}' '''))
    
    return redirect('/manajer/tim/')

def delete_pelatih(request):
    if (request.session.get('username') == None):
        return redirect('/login/')
    if (request.session.get('role') != 'manajer'):
        if (request.session.get('role') == None):
            return redirect('/')
        return redirect(f'/{request.session.get("role")}')
    if (request.session.get('nama_tim') == None):
        return redirect('/manajer/tim/')
    id_pelatih = request.POST.get('id')
    print(id_pelatih)
    print(query(f'''UPDATE PELATIH SET nama_tim = NULL WHERE id_pelatih = '{id_pelatih}' '''))
    
    return redirect('/manajer/tim/')

def add_pemain(request):
    if (request.session.get('username') == None):
        return redirect('/login/')
    if (request.session.get('role') != 'manajer'):
        if (request.session.get('role') == None):
            return redirect('/')
        return redirect(f'/{request.session.get("role")}')
    if (request.session.get('nama_tim') == None):
        return redirect('/manajer/tim/')
    list_pemain = query(f''' SELECT * FROM PEMAIN WHERE nama_tim IS NULL ''')
    context = {'list_pemain': list_pemain}
    if (request.method == 'POST'):
        #print(request.POST.get('id'))
        #print(request.session.get('nama_tim'))
        query(f''' UPDATE PEMAIN SET nama_tim = '{request.session.get('nama_tim')}' WHERE id_pemain = '{request.POST.get('id')}' ''')
        return redirect('/manajer/tim/')
    return render(request, 'pilih_pemain.html', context)


def add_pelatih(request):
    if (request.session.get('username') == None):
        return redirect('/login/')
    if (request.session.get('role') != 'manajer'):
        if (request.session.get('role') == None):
            return redirect('/')
        return redirect(f'/{request.session.get("role")}')
    if (request.session.get('nama_tim') == None):
        return redirect('/manajer/tim/')
    list_pelatih = query(f''' SELECT p.id_pelatih, nama_depan, nama_belakang, string_agg(spesialisasi, ', ') as sp
        FROM non_pemain np
        JOIN pelatih p ON np.id = p.id_pelatih
        JOIN spesialisasi_pelatih sp ON p.id_pelatih = sp.id_pelatih
        WHERE p.nama_tim IS NULL
        GROUP BY p.id_pelatih, nama_depan, nama_belakang ''')

    context = {'list_pelatih': list_pelatih}
    if (request.method == 'POST'):
     #   print(request.POST.get('id'))
        response = query(f''' UPDATE PELATIH SET nama_tim = '{request.session.get('nama_tim')}' WHERE id_pelatih = '{request.POST.get('id')}' ''')
        if (isinstance(response, Exception)):
            context['message'] = response.args[0].split("\n")[0]
            return render(request, 'pilih_pelatih.html', context)
        else: 
            return redirect('/manajer/tim/')

    return render(request, 'pilih_pelatih.html', context)

def create_tim(request):
    # if user hasnt logged in
    if (request.session.get('username') == None):
        return redirect('/login/')
    if (request.session.get('role') != 'manajer'):
        if (request.session.get('role') == None):
            return redirect('/')
        return redirect(f'/{request.session.get("role")}')
    if (request.session.get('nama_tim') != None):
        return redirect('/manajer/tim/')
    if (request.method == 'POST'):
        nama_tim = request.POST.get('nama_tim')
        universitas = request.POST.get('universitas')

        response = query(f''' INSERT INTO TIM (nama_tim, universitas) VALUES ('{nama_tim}', '{universitas}') ''')
        if (isinstance(response, Exception)):
            context = {'message': "Nama tim sudah terdaftar"}
            return render(request, 'form_pendaftaran_tim.html', context)
        
        id = query(f'''
            SELECT id_manajer FROM MANAJER WHERE username = '{request.session.get('username')}'
            ''')[0]['id_manajer'] 
        response = query(f'''
            INSERT INTO TIM_MANAJER (id_manajer, nama_tim)
            VALUES ('{id}', '{nama_tim}')
            ''' )
        print(response)
        request.session['nama_tim'] = nama_tim
        return redirect('/manajer/tim/')
    return render(request, 'form_pendaftaran_tim.html')
    