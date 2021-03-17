import json
import re

from django.http    import JsonResponse
from django.views   import View

from order.models   import (
                            Order,
                            OrderItem,
                            OrderStatus,
                            )
from user.models    import User, Address
from product.models import Product
from decorators.utils     import login_required

class OrderItemView(View):
    @login_required
    def get(self.request):
        try:
            order_items = request.user.order_item.prefetch_related('product')

        order_item_list = [{
            'category'      : i.product.category.name,
            'product_name'  : i.product.name,
            'image'         : i.product.main_image,
            'price'         : i.product.price ,
            'quantity'      : quantity,
            'create_at'     : i.product.creat_at,
        } for i in order_item_list ]

        return JsonResponse({'MESSAGE':'ORDER ITEM LIST': order_item_list}, status=200)

    @login_required
    def post(self, request):
        data         = json.loads(request.body)
        product = Product.objects.get(id=data['product_id'])

        try:
            order_item = OrderItem.objects.get(product__id=data['product_id'], user__id=request.user.id)
            if order_item:
                if order_item.product.name == data['product_name']:
                    order_item.quantity += int(data['quantity'])
                    order_item.save()
        except OrderItem.DoesNotExist:
            user       = User.objects.get(id=request.user.id) 
            order_item = OrderItem(
                user    =user,
                product =data['product_id'],
                quantity=int(data['quantity']),
            )
            order_item.save()

        except Product.DoesNotExist:
            return JsonResponse({'MESSAGE':data['product_id']+'DOES NOT EXIST'}, status=400)
        except KeyError:
            return JsonResponse({'MESSAGE':'KEY ERROR OCCURED'}, status=400)
        except ValueError:
            return JsonResponse({'MESSAGE':'VALUE ERROR OCCURED'}, status=400)

        @login_required
        def put(self,request): # 
            data = json.loads(request.body)
            order_item = OrderItem.objects.get(user = request.user, id=data['order_item'])
            order_item.quantity = data['order_item_num']
            return JsonResponse({'MESSAGE':})
        except:
            return JsonResponse({'MESSAGE':},)

        @login_required
            def delete(self, request):
                try :
                    data = json.loads(request.body)
                    order_item = OrderItem.objects.get(id=data['order_item_num'])  
                    cart.delete()
                    return JsonResponse({'MESSAGE':'DELETEED ORDER ITEM SUCCESSFULLY'}, status=200)
                    
                except OrderItem.DoesNotExist :
                    return JsonResponse({"MESSAGE" :"ORDER ITEM DOES NOT EXISTS"}, status = 400)   
                except KeyError:
                    return JsonResponse({"MESSAGE" : 'KEY_ERROR'}, status = 400)