import json
import uuid
from json               import JSONDecodeError
from datetime           import datetime, timedelta

from django.db          import transaction
from django.db.models   import Q
from django.http        import JsonResponse
from django.views       import View
from django.utils       import timezone

from order.models       import (
                            Order,
                            Cart,
                            OrderStatus,
                            )
from user.models        import User, Address
from product.models     import Product
from decorators.utils   import login_required
from order.order_list   import get_order_list


class CartView(View):
    @login_required
    def get(self,request):
        try:
            user = request.user
            carts = Order.objects.select_related('cart').prefetch_related('product', 'cart', 'user').get(user=user, status__name='장바구니')

            result = [{
                    'cartId'    : cart.id,
                    'productId' : cart.product_id,
                    'product'   : cart.product.name,
                    'option'    : cart.option,
                    'quantity'  : cart.quantity,
                    'totalPrice': int(cart.total_price),
                    'eachPrice' : cart.product.price,
                    'urlImage'  : cart.product.image_url,
                }for cart in carts]

            return JsonResponse({'MESSAGE':'SUCCESS', 'result':result}, status=200)
        except Order.DoesNotExist as err:
            return JsonResponse({'message': err}, status=400)

    @login_required
    def post(self, request):
        try:
            data    = json.loads(request.body)
            order_status = OrderStatus.objects.get(name='장바구니')

            if not Order.objects.filter(user=request.user, status=order_status).exists():
                with transaction.atomic():
                    order = Order.objects.create(
                        user         = request.user,
                        status       = order_status,
                        serial_number=str(uuid.uuid4())
                        ) # 매번 유니크한 값 생성
                    

                    Cart.objects.create(
                        order       = order,
                        product_id  = data['productId'],
                        quantity    = data['quantity'],
                        total_price = int(data['totalPrice']),
                        )
                return JsonResponse({'message':'SUCCESS'},status=200)
            
            order = Order.objects.prefetch_related('product').\
                                  get(user_id=request.user.id, status=order_status)
            if not Cart.objects.get(user=request.user, status=order_status).exists():
                Cart.objects.create(
                    order       =order,
                    product_id  =data['productId'],
                    quantity    = data['quantity'],
                    total_price = int(data['totalPrice']),
                )
                return JsonResponse({'message':'SUCCESS'}, status=200)
        except JSONDecodeError               as e : error=e
        except KeyError                      as e : error=e
        except Product.DoesNotExist          as e : error=e
        except Order.DoesNotExist            as e : error=e
        except Order.MultipleObjectsReturned as e : error=e
        except IntegrityError                as e : error=e
        finally : 
            return JsonResponse({'message':error}, status=400)

    @login_required
    def delete(self, request):
        try :
            cart_list = request.GET.getlist('cartId') # reference http://yong27.biohackers.net/303
            cart_ids  = [int(single_cart_id) for single_cart_id in cart_list]
            cart      = Cart.objects.filter(id__in=cart_ids)

            if cart.exists():
                cart.delete()
                return JsonResponse({'message':'SUCCESS'}, status=200)
            return JsonResponse({'message':'CART DOES NOT EXIST'},status=400)                    
        
        except KeyError:
            return JsonResponse({"MESSAGE" : 'KEY_ERROR'}, status = 400)

class PaymentView(View):
    @login_required
    def get(self, request):
        try:
            orders= Order.objects.prefetch_related('product__cart_set').\
                                filter(user=request.user, status__name='장바구니')

            product =[{
                "cartId"        : cart_list.id,
                "productId"     : cart_list.product_id,
                "product"       : cart_list.product.name,
                "option"        : cart_list.option,
                "quantity"      : cart_list.quantity,
                "totalPrice"    : cart_list.total_price,
                "eachPrice"     : cart_list.product.price,
                "urlImage"      : cart_list.product.image_url,
            } for cart_list in order.cart_set.all() ]

            sender  = {
                'name'          : request.user.name,
                'address'       : request.home_address,
                'homeNumber'    : request.home_phone,
                'MobileNumber'  : request.cell_phone,
                'email'         : request.user.email,
            }

            receipient = {
                'receipient'    : request.user.name,
                'address'       : request.home_address,
                'homeNumber'    : request.home_phone,
                'MobileNumber'  : request.cell_phone,
            }
            return JsonResponse({
                'message':'SUCCESS',
                'results':{
                    'product_info'  : product,
                    'sender'        : sender,
                    'receipient'    : receipient,
                }}, status=200)
        except Order.DoesNotExist            as error : 
            return JsonResponse({'message':error}, status=400)


class OrderListView(View):
    @login_required
    def get(self, request):
        result = get_order_list(request)
        return JsonResponse({'message':'SUCCESS', 'data':result}, status=200)

    @login_required
    def patch(self, request):
        CONFIRM_STATUS = 4

        data = json.loads(request.body)

        try:
            cart = Cart.objects.get(order_id=data['orderId'], product_id=data['productId'])
            cart.status_id = CONFIRM_STATUS
            cart.save()

            result = get_order_list(request)

            return JsonResponse({'message':'SUCCESS', 'data': result}, status=200)
        except KeyError          as e: error=e 
        except Cart.DoesNotExist as e: error=e 
        finally:
            return JsonResponse({'message':error}, status=400) 