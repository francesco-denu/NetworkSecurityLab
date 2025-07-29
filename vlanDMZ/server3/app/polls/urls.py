from django.urls import path
from .views import register_view, login_view, logout_view, hello_world
from . import views


urlpatterns = [
    path('hello/', hello_world, name='hello_world'),
    path('register/', register_view, name='register'),
    path('login/', login_view, name='login'),
    path('logout/', logout_view, name='logout'),
    path('create_poll/', views.create_poll, name='create_poll'),

]

