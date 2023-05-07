from django.shortcuts import render

# Create your views here.
def show_panitia(request):
    context = {
    }
    return render(request, "managePertandingan.html", context)
