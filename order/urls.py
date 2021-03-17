from django.urls import path

from order.views import OrderListView, CartView, PaymentView

urlpatterns = [
    path('',         OrderListView.as_view()),
    path('/cart',    CartView.as_view()),
    path('/payment', PaymentView.as_view()),
]