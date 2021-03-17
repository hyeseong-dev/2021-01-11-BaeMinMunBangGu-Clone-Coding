from django.urls import path,include
from user        import views

urlpatterns = [
    path('/signup',   views.SignUpView.as_view()),
    path('/login',    views.LoginView.as_view()),
    path('/profile',  views.ProfileView.as_view()),
]