import json

from datetime         import datetime, timedelta

from django.utils     import timezone
from django.views     import View
from django.http      import JsonResponse
from django.db.models import Q
from django.db        import transaction, IntegrityError


from decorators.utils import login_required
from user.models      import User
from order.order_list import get_order_list
from order.models     import Order, Cart
from order.views      import get_order_list
from product.models   import (
    ProductLike, 
    Product, 
    ProductImage,
    MatchingReview, 
    Review, 
    Category
)
from product         import sorts



SORT_TYPES = {
            '0' : '-create_time',
            '1' : '-sales_count',
            '2' : 'price',
            '3' : '-price'    
        }

SORTINGS = [
    {    
        'id'   : 0, 
        'name' : '신상품순',
    },
    {   
        'id'   : 1, 
        'name' : '인기상품순',
    },
    {
        'id'   : 2, 
        'name' : '낮은 가격순',
    },
    {
        'id'     : 3, 
        'name' : '높은 가격순',
    } 
]


class HomeView(View):
    def get(self, request):
        LIMIT = 8
        products = Product.objects.select_related('category')
        best_items = sorts.check_best_items()
        result = {}

        result['theBest'] = [{
                            'id':product.id,
                            'name':product.name,
                            'imageURL': product.image_url,
                            'price': product.price,
                            'category': product.category.id,
                            'sale':product.sale,
                            'new':True if product.create_at > timezone.now()-timedelta(days=30) else False,
                            'best':sorts.is_best(best_items, product.id),
                            'sale':bool(product.sale),
                        }for product in products.order_by('-total_sales')[:LIMIT]]

        result['theNew'] = [{
                            'id':product.id,
                            'name':product.name,
                            'imageURL': product.image_url,
                            'price': product.price,
                            'category': product.category.id,
                            'sale':product.sale,
                            'new':True if product.create_at > timezone.now()-timedelta(days=30) else False,
                            'best':sorts.is_best(best_items, product.id),
                            'sale':bool(product.sale),
                        }for product in products.order_by('-sale')[:LIMIT]]

        result['theSale'] = [{
                            'id':product.id,
                            'name':product.name,
                            'imageURL': product.image_url,
                            'price': product.price,
                            'category': product.category.id,
                            'sale':product.sale,
                            'new':True if product.create_at > timezone.now()-timedelta(days=30) else False,
                            'best':sorts.is_best(best_items, product.id),
                            'sale':bool(product.sale),
                        }for product in products.filter(sale__gt=0)[:LIMIT]]

        return JsonResponse({'message':'SUCCESS','RESULT':result}, status=200)


class CategoryView(View):  
    def get(self,request):
        category_id = request.GET.get('category_id')
        ordering = request.GET.get('ordering') 

        products = Product.objects.select_related('category').filter(category_id=category_id)

        results = [{
            'id'        : product.id,
            'name'      : product.name,
            'sale'      : product.sale,
            'stock'     : product.stock,
            'price'     : product.price,
            'imageURL'  : product.image_url,
            'category'  : product.category.id,
            'new'       : True if product.create_at > timezone.now()-timedelta(days=30) else False,
            'best'      : sorts.is_best(best_items, product.id),
            'sale'      : bool(product.sale)
        } for product in products.order_by('-total_sales', SORT_TYPES['ordering']) ]
        return JsonResponse({'RESULT':results,'SORTING':SORTINGS, 'PRODUCT COUNT':products.count()}, status=200, safe=True)


class ProductDetailView(View):
    def get(self, request, product_id):
        try:
            product = Product.objects.prefetch_related('user','productimage_set','review_set').filter(id=product_id)

            result = {
                'id' :          product.id,
                'name' :        product.name,
                'sale' :        product.sale,
                'price' :       product.price,
                'stock' :       product.stock,
                'thumbnailURL': product.image_url,
                'imageURL' :    [single.image_url for single in product.productimage_set.all()],
                'reviews' : [{
                                'id'         : review.id,
                                'reviewTitle': review.title,
                                'content'    : review.content,
                                'ratings'    : review.start_rating,
                                'imgageURL'  : review.image_url,
                                'createAt'   : review.create_at,
                                'userId'     : review.user.account,
                }for review in product.review_set.all()],
            }

            return JsonResponse({'DATA':{'PRODUCT': result}}, status=200)
        except Product.DoesNotExist:
            return JsonResponse({"MESSAGE":"PRODUCT_DOES_NOT_EXIST"}, status = 404)


class ProductLikeView(View):
    @login_required
    def get(self, request):
        
        results = [{
            'id'       : like.product.id,
            'name'     : like.product.name,
            'imageURL' : like.product.image_url, 
            'category' : like.product.category.id, 
        }for like in request.user.productlike_set.all()]

        return JsonResponse({'message':'SUCCESS', 'RESULT':results}, status=200)

    @login_required
    def post(self, request):
        data = json.loads(request.body)

        like, is_like = ProductLike.objects.get_or_create(user_id=request.user.id,\
                                                         product_id=data['productId'])
        
        if not is_like:like.delete()
        return JsonResponse({'message': 'SUCCESS'}, status=200)

class ReviewView(View):
    def get(self, request, product_id):
        
        reviews = [{
            'user'      :review.user.account,
            'content'   :review.content,
            'Ratings'   : review.star_rating,
            'imageURL'  :review.image_url,
            'createAt'  :review.create_at,
        }for review in Review.objects.select_related('product').filter(product_id=product_id)]
        return JsonResponse({'message': 'SUCCESS', 'reviews':reviews}, status=200)

    @login_required
    def post(self, request):
        try:
            data = json.loads(request.body)
            user = request.user
            product_id = data['productId']
            order_id = data['orderId']

            if MatchingReview.objects.filter(product_id=product_id, order_id=order_id).exists():
                return JsonResponse({'message':'ALREADY HAVE IT'}, status=400)
            
            with transaction.atomic():
                review = Review.objects.create(
                    product_id=product_id,
                    user_id=user.id,
                    title=data['title'],
                    content=data['content'],
                    star_rating=data['Rating'],
                    image_url=data['imageURL'] if data.get('image_url') else 'None'
                )
                MatchingReview.objects.create(
                    review=review,
                    order_id=order_id,
                    product_id=product_id,
                )
            result=get_order_list(request)
            return JsonResponse({'message':'SUCCESS', 'RESULT':result}, status=200)           
        except KeyError:
            return JsonResponse({'message':'KEY_ERROR'}, status=400)
        except IntegrityError:
            return JsonResponse({'message':'INTEGRITY_ERROR'}, status=400)