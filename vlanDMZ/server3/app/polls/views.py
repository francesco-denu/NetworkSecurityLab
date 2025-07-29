from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.forms import AuthenticationForm
from .forms import RegisterForm, PollForm, ChoiceFormSet
from django.http import HttpResponse
import logging
from django.contrib.auth.decorators import login_required
from .models import Poll, Choice

logger = logging.getLogger(__name__)


def hello_world(request):
    return HttpResponse("Hello, world!")
    
def register_view(request):
    if request.method == "POST":
        form = RegisterForm(request.POST)
        
        # Debugging: Check if form is valid or not
        if form.is_valid():
            form.save()
            return redirect('login')
        else:
            # Log form errors
            logger.error("Form is not valid. Errors: %s", form.errors)

            # Debugging: Display errors directly in the console (or use logging)
            print("Form is not valid!")
            print("Form errors:", form.errors)
        
    else:
        form = RegisterForm()
    
    return render(request, 'polls/register.html', {'form': form})



def login_view(request):
    if request.method == "POST":
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('hello_world')  # or any page you want
    else:
        form = AuthenticationForm()
    return render(request, 'polls/login.html', {'form': form})

def logout_view(request):
    logout(request)
    return redirect('login')


@login_required
def create_poll(request):
    if request.method == 'POST':
        form = PollForm(request.POST)
        formset = ChoiceFormSet(request.POST)

        if form.is_valid() and formset.is_valid():
            poll = form.save(commit=False)
            poll.created_by = request.user
            poll.save()
            choices = formset.save(commit=False)
            for choice in choices:
                choice.poll = poll
                choice.save()
            return redirect('poll_detail', poll_id=poll.id)
    else:
        form = PollForm()
        formset = ChoiceFormSet()

    return render(request, 'polls/create_poll.html', {
        'form': form,
        'formset': formset
    })
    