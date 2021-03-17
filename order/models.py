from django.db import models

class Order(models.Model):
    user            = models.ForeignKey('user.user', on_delete=models.CASCADE)
    status          = models.ForeignKey('orderstatus', on_delete=models.CASCADE)
    address         = models.ForeignKey('user.address', on_delete=models.CASCADE, null=True)
    product         = models.ManyToManyField('product.product', through='cart', related_name='shopping_cart')
    create_at       = models.DateTimeField(auto_now_add=True)
    total_price     = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    is_confirmed    = models.BooleanField(default=False)
    serial_number   = models.CharField(max_length=50)

    class Meta:
        db_table = 'orders'

class OrderStatus(models.Model):
    name        = models.CharField(max_length=20)

    def __str__(self):
        return f'{self.name}'

    class Meta:
        db_table = 'order_statuses'

class Cart(models.Model):
    order       = models.ForeignKey('order.order', on_delete=models.CASCADE)
    product     = models.ForeignKey('product.product', on_delete=models.CASCADE)
    option      = models.CharField(max_length=100, null=True)
    quantity    = models.SmallIntegerField()
    total_price = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    status      = models.ForeignKey('order.cartstatus', on_delete=models.CASCADE, default=1)

    class Meta:
        db_table = 'carts'

class CartStatus(models.Model):
    name = models.CharField(max_length=200)

    class Meta:
        db_table = 'cart_statuses'