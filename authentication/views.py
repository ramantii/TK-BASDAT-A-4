from django.shortcuts import redirect, render
from django.db import IntegrityError, connections
from psycopg2.extras import RealDictCursor
from psycopg2.errors import UniqueViolation

from . import forms

from utils.runquery import run_query
from utils.fetchall import fetch_all_query

def login(request):
    context = {}
    login_form = forms.LoginForm()
    context['form'] =  login_form

    return render(request, 'login/login.html', context)

def register(request):
    context = {}
    # register_form = forms.LoginForm()
    # context['form'] =  register_form

    return render(request, 'register/register.html', context)

def register_views(request):
    error = False
    context = {}    

    if request.method == "POST":
        data = request.POST

        try:
            if (data.get('username-admin') and data.get('password-admin')):
                username = data.get('username-admin')
                password = data.get('password-admin')
                
                run_query(f"INSERT INTO AKUN VALUES('{username}');")
                run_query(f"INSERT INTO ADMIN VALUES('{username}', '{password}');")

                request.session["username"] = username
                request.session["role"] = 'admin'
                request.session.set_expiry(0)
                request.session.modified = True

                return redirect('/')
            elif (data.get('username') and data.get('password')):
                username = data.get('username')
                password = data.get('password')
                email = data.get('email')
                no_hp = data.get('no_hp')

                run_query(f"INSERT INTO AKUN VALUES('{username}');")
                run_query(f"INSERT INTO PEMAIN VALUES('{username}', '{email}', '{password}', '{no_hp}', 0);")

                request.session["username"] = username
                request.session["role"] = 'pemain'
                request.session.set_expiry(0)
                request.session.modified = True

                return redirect('/')
        except UniqueViolation as e:
            if (data.get('username')):
                error = "username "+ data['username']+" sudah terdaftarkan di sistem"
            else:
                error = "username "+ data['username-admin']+" sudah terdaftarkan di sistem"
        
        context['error'] = error
    return render(request, 'register/register.html', context)