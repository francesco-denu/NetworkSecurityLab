from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from .models import Poll, Choice
from django.forms import inlineformset_factory

class RegisterForm(UserCreationForm):
    email = forms.EmailField(required=True)

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']
        
class PollForm(forms.ModelForm):
    class Meta:
        model = Poll
        fields = ['question']

ChoiceFormSet = inlineformset_factory(Poll, Choice, fields=('choice_text',), extra=3, can_delete=False)