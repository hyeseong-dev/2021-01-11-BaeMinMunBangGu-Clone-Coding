from django.db import models
from datetime import date

class Order(models.Model):
    user          = models.ForeignKey('user.User',    on_delete=models.CASCADE, related_name='orders')
    order_status  = models.BooleanField(default=True)
    create_at     = models.DateField(auto_now_add=True)
    
    class Meta:
      db_table = 'orders'


class OrderStatus(models.Model):
    status    = models.CharField(max_length=45)

    class Meta:
      db_table = 'order_status'
      

class OrderItem(models.Model): # Cart 개념
    user      = models.ForeignKey('user.User',
                                  on_delete=models.CASCADE,
                                  related_name='order_items')
    product   = models.ForeignKey('product.Product', 
                                    on_delete=models.CASCADE, 
                                    related_name='order_items')
    order     = models.ForeignKey('Order',           
                                    on_delete=models.CASCADE, 
                                    related_name='order_items', 
                                    null=True, blank=True)
    quantity  = models.IntegerField(default=1)
    create_at = models.DateField(auto_now_add=True)
    class Meta:
      db_table = 'order_items'

    def sub_total(self):
      return self.product.price * self.quantity

    def __str__(self):
      return self.product
    
    