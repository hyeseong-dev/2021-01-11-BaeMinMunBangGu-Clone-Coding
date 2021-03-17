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
    product         = models.ManyToManyField('product.product', through='recentview', related_name='recently_view')
    create_at       = models.DateTimeField(auto_now_add=True)
    update_at       = models.DateTimeField(auto_now=True)
    total_price     = models.DecimalField(max_digits=18, decimal_places=2, default=0)

    def __str__(self):
        return f'{self.name}'

    class Meta:
        db_table = 'users'


class Grade(models.Model):

    GRADE_NORMAL = '일반회원'
    GRADE_VIP    = 'VIP회원'
    GRADE_VVIP   = 'VVIP회원'
    GRADE_VVVIP  = 'VVVIP회원'
    GRADE_STAFF  = '관리자'

    GRADE_CHOICES = (
        (GRADE_NORMAL, '일반회원'),
        (GRADE_VIP, 'VIP회원'),
        (GRADE_VVIP, 'VVIP회원'),
        (GRADE_VVVIP, 'VVVIP회원'),
        (GRADE_STAFF, '관리자'),
    )

    name = models.CharField(max_length=20, choices=GRADE_CHOICES, default=GRADE_NORMAL, blank=True)

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

    COUPON_NEW  = '회원가입쿠폰'
    COUPON_1    = '1만원쿠폰'
    COUPON_10   = '10만원쿠폰'
    COUPON_100  = '100만원쿠폰'
    COUPON_HALF = '평생반값쿠폰'

    COUPON_CHOICES = (
        (COUPON_NEW, '회원가입쿠폰'),
        (COUPON_1,   '1만원쿠폰'),
        (COUPON_10,  '10만원쿠폰'),
        (COUPON_100, '100만원쿠폰'),
        (COUPON_HALF,'평생반값쿠폰'),
    )

    name        = models.CharField(max_length=30, choices=COUPON_CHOICES, default=COUPON_NEW, blank=True)
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


class RecentView(models.Model):
    user        = models.ForeignKey('User', on_delete=models.CASCADE)
    product     = models.ForeignKey('product.Product', on_delete=models.CASCADE)
    create_at   = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'recently_views'


