from django.db import models


class User(models.Model):
    account         = models.CharField(max_length=20, unique=True)
    password        = models.CharField(max_length=300)
    name            = models.CharField(max_length=20)
    email           = models.EmailField(max_length=50)
    cell_phone      = models.CharField(max_length=20)
    home_phone      = models.CharField(max_length=20, null=True)
    home_address    = models.CharField(max_length=300, null=True)
    phone_spam      = models.BooleanField(default=False)
    email_spam      = models.BooleanField(default=False)
    grade           = models.ForeignKey('grade', on_delete=models.CASCADE)
    coupon          = models.ManyToManyField('coupon', through='usercoupon')
    product         = models.ManyToManyField('product.product', through='recentlyview', related_name='recently_view')
    create_at       = models.DateTimeField(auto_now_add=True)
    update_at       = models.DateTimeField(auto_now=True)
    total_price     = models.DecimalField(max_digits=18, decimal_places=2, default=0)

    def __str__(self):
        return f'{self.name}'

    class Meta:
        db_table = 'users'


class Grade(models.Model):
    name = models.CharField(max_length=20)

    def __str__(self):
        return f'{self.name}'

    class Meta:
        db_table = 'grades'


class Point(models.Model):

    user            = models.ForeignKey('user', on_delete=models.CASCADE)
    content         = models.CharField(max_length=50)
    validity        = models.DateTimeField()
    remaining_point = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    value           = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    create_at       = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.content}'

    class Meta:
        db_table = 'points'


class Coupon(models.Model):
    name        = models.CharField(max_length=30)
    price       = models.DecimalField(max_digits=8, decimal_places=2)

    def __str__(self):
        return f'{self.name}'

    class Meta:
        db_table = 'coupons'


class UserCoupon(models.Model):
    user        = models.ForeignKey('User', on_delete=models.CASCADE)
    coupon      = models.ForeignKey('Coupon', on_delete=models.CASCADE)
    validity    = models.DateTimeField() 
    create_at   = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'user_coupons'


class Address(models.Model):
    user        = models.ForeignKey('User', on_delete=models.CASCADE)
    name        = models.CharField(max_length=20)
    to_person   = models.CharField(max_length=20)
    to_address  = models.CharField(max_length=300)
    home_phone  = models.CharField(max_length=20, null=True)
    cell_phone  = models.CharField(max_length=20)
    is_default  = models.BooleanField(default=False)

    def __str__(self):
        return f'{self.name}'

    class Meta:
        db_table = 'addresses'


class RecentlyView(models.Model):
    user        = models.ForeignKey('User', on_delete=models.CASCADE)
    product     = models.ForeignKey('product.Product', on_delete=models.CASCADE)
    create_at   = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'recently_views'


