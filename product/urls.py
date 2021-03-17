from django.urls import path
from .views      import (
    ProductDetailView, 
    CategoryView, 
    ReviewView, 
    ProductLikeView)

urlpatterns = [
    path('',                         CategoryView.as_view()),
    path('/<int:product_id>',        ProductDetailView.as_view()),
    path('/like',                    ProductLikeView.as_view()),
    path('/review',                  ReviewView.as_view()),
    path('/review/<int:product_id>', ReviewView.as_view()),
]