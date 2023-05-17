from django.shortcuts import redirect, render
from django.db import IntegrityError, connections
from psycopg2.extras import RealDictCursor
from psycopg2.errors import UniqueViolation
from django.http import HttpResponse, HttpRequest
import uuid

# import query.py
from utils.query import query


from . import forms
'''
from utils.runquery import run_query
from utils.fetchall import fetch_all_query
'''


# show landing_page.html
def landing_page(request):
    if (request.session.get('username') != None):
        return redirect(f'''/{request.session.get('role')}/''')
    context = {}
    return render(request, 'landing_page.html', context)

# show register_manajer.html
def show_register_manajer(request):
    if (request.session.get('username') != None):
        return redirect(f'''/{request.session.get('role')}/''')
    context = {'role': 'manajer' }
    
    return render(request, 'register/register_manajer_penonton.html', context)

# show register_panitia.html
def show_register_panitia(request):
    if (request.session.get('username') != None):
        return redirect(f'''/{request.session.get('role')}/''')
    context = {'role': 'panitia' }
    return render(request, 'register/register_panitia.html', context)

# show register_penonton.html
def show_register_penonton(request):
    if (request.session.get('username') != None):
        return redirect(f'''/{request.session.get('role')}/''')
    context = {'role': 'penonton'}
    return render(request, 'register/register_manajer_penonton.html', context)

def login(request):
    if request.session.get('username') != None:
        return redirect(f'/{request.session.get("role")}')
    context = {}
    login_form = forms.LoginForm()
    context['form'] =  login_form
    if request.method == 'POST':
        username = request.POST.get("username")
        password = request.POST.get("password")
        validate = f''' SELECT * FROM USER_SYSTEM WHERE username = '{username}' AND password = '{password}' '''
        response = query(validate)

        if len(response) == 0:
            context['messages'] = 'Incorrect username or password'
            return render(request, 'login/login.html', context)
        else:
            request.session['username'] = username
            role = get_role(username)
            request.session['role'] = role

            if role == 'manajer':
                return redirect('/manajer')
            elif role == 'panitia':
                return redirect('/panitia')
            else:	
                return redirect('/penonton')
        
    return render(request, 'login/login.html', context)

def register(request):
    if (request.session.get('username') != None):
        return redirect(f'''/{request.session.get('role')}/''')
    context = {}
    # register_form = forms.LoginForm()
    # context['form'] =  register_form

    return render(request, 'register/register.html', context)

def logout(request):
    request.session.flush()
    return redirect('/')

def register_submit(request):
    if (request.session.get('username') != None):
        return redirect(f'''/{request.session.get('role')}/''')
    id = uuid.uuid4()
    username = request.POST.get("username")
    password = request.POST.get("password")
    nama_depan = request.POST.get("nama_depan")
    nama_belakang = request.POST.get("nama_belakang")
    email = request.POST.get("email")
    no_hp = request.POST.get("phoneNumber")
    alamat = request.POST.get("address")
    non_pemain_status = request.POST.getlist("status")
    role = request.POST.get("role")
    insert_user_system = f''' INSERT INTO USER_SYSTEM VALUES ('{username}', '{password}')
    '''
    insert_non_pemain = f''' INSERT INTO NON_PEMAIN (id, nama_depan, nama_belakang, nomor_hp, email, alamat) VALUES ('{id}', '{nama_depan}', '{nama_belakang}', {no_hp},'{email}', '{alamat}')'''
    
    # print(query(insert_user_system).args[0].split("\n")[0])
    response = query(insert_user_system)

    if isinstance(response, Exception):
        # return to register_manajer.html, with error message
        context = {
            'messages': response.args[0].split("\n")[0],
            'role': role
        }
        if role == 'panitia':
            return render(request, 'register/register_panitia.html', context)
        return render(request, 'register/register_manajer_penonton.html', context)
    
    response = query(insert_non_pemain)
    
    for elements in non_pemain_status:
        response = query(f''' INSERT INTO STATUS_NON_PEMAIN VALUES ('{id}', '{elements}')''')

    if (role == 'manajer'):
        response = query(f''' INSERT INTO MANAJER VALUES ('{id}' , '{username}')''')
    elif (role == 'penonton'):
        response = query(f''' INSERT INTO PENONTON VALUES ('{id}' , '{username}')''')
    elif (role == 'panitia'):
        jabatan = request.POST.get("jabatan")
        response = query(f''' INSERT INTO PANITIA VALUES ('{id}' , '{jabatan}', '{username}')''')

    return redirect('authentication:login')


def get_role(username):
    find_user = f''' SELECT * FROM MANAJER WHERE username = '{username}' '''
    response = query(find_user)
    if len(response) == 0:
        find_user = f''' SELECT * FROM PANITIA WHERE username = '{username}' '''
        response = query(find_user)
        if len(response) == 0:
            return 'penonton'
        else:
            return 'panitia'
    else:
        return 'manajer'

