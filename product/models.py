from django.db import models

class Product(models.Model):
    category        = models.ForeignKey('category', on_delete=models.CASCADE)
    name            = models.CharField(max_length=50)
    price           = models.DecimalField(max_digits=8, decimal_places=2)
    stock           = models.PositiveIntegerField(default=0)
    sale            = models.DecimalField(max_digits=5, decimal_places=2,default=0)
    user            = models.ManyToManyField('user.user', through='productlike',related_name='product_like')
    image_url       = models.URLField(max_length=4000)
    total_sales     = models.IntegerField()
    create_at       = models.DateTimeField(auto_now_add=True)
    update_at       = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.name}'
    
    class Meta:
        db_table = 'products'

class Category(models.Model):
    name            = models.CharField(max_length=20)

    def __str__(self):
        return f'{self.name}'

    class Meta:
        db_table = 'categories'

class ProductImage(models.Model):
    product         = models.ForeignKey('product', on_delete=models.CASCADE)
    image_url       = models.URLField(max_length=4000)

    class Meta:
        db_table = 'product_images'

class ProductLike(models.Model):
    product         = models.ForeignKey('product', on_delete=models.CASCADE)
    user            = models.ForeignKey('user.user', on_delete=models.CASCADE)

    class Meta:
        db_table = 'product_likes'

class ProductOption(models.Model):
    product         = models.ForeignKey('product', on_delete=models.CASCADE)
    name            = models.CharField(max_length=100)
    stock           = models.PositiveIntegerField(default=0)

    def __str__(self):
        return f'{self.name}'

    class Meta:
        db_table = 'product_options'

class Review(models.Model):
    product         = models.ForeignKey('product', on_delete=models.CASCADE)
    user            = models.ForeignKey('user.user', on_delete=models.CASCADE)
    content         = models.CharField(max_length=4000)
    star_rating     = models.SmallIntegerField()
    image_url       = models.URLField(max_length=4000)
    create_at       = models.DateTimeField(auto_now_add=True)
    title           = models.CharField(max_length=100)

    class Meta:
        db_table = 'reviews'

class MatchingReview(models.Model):
    review          = models.ForeignKey('review', on_delete=models.CASCADE)
    order           = models.ForeignKey('order.order', on_delete=models.CASCADE)
    product         = models.ForeignKey('product.product', on_delete=models.CASCADE, related_name='matching_product')

    class Meta:
        db_table = 'matching_reviews'


class ProductInquiry(models.Model):
    product         = models.ForeignKey('product', on_delete=models.CASCADE)
    user            = models.ForeignKey('user.user', on_delete=models.CASCADE)
    title           = models.CharField(max_length=50)
    content         = models.CharField(max_length=4000)
    answer_title    = models.CharField(max_length=50)
    answer_content  = models.CharField(max_length=4000)
    answer_status   = models.ForeignKey('answerstatus', on_delete=models.CASCADE)
    create_at       = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'product_inquiries'

class AnswerStatus(models.Model):
    name            = models.CharField(max_length=20)

    class Meta:
        db_table = 'answer_statuses'