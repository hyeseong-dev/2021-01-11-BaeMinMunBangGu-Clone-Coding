import bcrypt
import json
import jwt
import re

from datetime           import datetime, timedelta
from django.http        import JsonResponse
from django.db.models   import Count
from django.views       import View

from my_settings        import SECRET_KEY, ALGORITHM
from decorators.utils   import (
    login_required,
    account_validation,
    password_check,
    email_validation,
    username_validation,
    phone_validation,
    check_duplication
)
from order.models       import (
    Order, 
    OrderStatus
)
from user.models        import (
    User,
    Coupon,
    Grade,
    UserCoupon,
    RecentView,
    Point,
)                                                


class LoginView(View):
    def post(self, request):
        try:
            data        = json.loads(request.body)
            account     = data['account']
            
            if not User.objects.filter(account=data['account']).exists():
                return JsonResponse({'MESSAGE':'INVALID USER INFORMATION'}, status=401)

            user = User.objects.get(account=account)

            if not bcrypt.checkpw(data['password'].encode('utf-8'), user.password.encode('utf-8')):
                return JsonResponse({'message':'INVALID PASSWORD'}, status=401)

            access_token = jwt.encode({'user_pk': user.id}, SECRET_KEY, algorithm=ALGORITHM)
            return JsonResponse({'MESSAGE':'SUCCESS','accessToken':access_token}, status=200, safe=True)

        except KeyError :
            return JsonResponse({'MESSAGE':'KEY ERROR'}, status=400)
        except ValueError:
            return JsonResponse({'MESSAGE':'VALUE ERROR'},status=400)


class SignUpView(View):
    def post(self, request):
        try:
            data     = json.loads(request.body)
            account  = data['account']
            password = data['password']
            name     = data['name']
            email    = data['email']
            phone    = data['phone']

            if not account_validation(account): 
                return JsonResponse({"MESSAGE":'NOT VALID ACCOUNT'}, status=400)

            if password_check(password)!=True:
                return password_check(password)

            if not email_validation(email):
                return JsonResponse({"MESSAGE":'NOT VALID EMAIL'}, status=400)

            if not username_validation(name):
                return JsonResponse({"MESSAGE":'NOT VALID NAME'}, status=400)

            if not phone_validation(phone):
                return JsonResponse({"MESSAGE":'NOT VALID PHONE'}, status=400)
            
            if check_duplication(account=account,email=email, phone=phone): 
                return JsonResponse({'MESSAGE': 'INFORMATION REGISTERED ALREADY!'}, status=409)

            user = User.objects.create(
                    account      = account,
                    password     = bcrypt.hashpw(password.encode('utf-8'),bcrypt.gensalt()).decode(), # hash이후 바로 decode,
                    name         = name,
                    email        = email,
                    cell_phone   = cell_phone,
                    home_phone   = home_phone,
                    home_address = home_address,
                    phone_spam   = phone_spam,
                    email_spam   = email_spam,
                    grade        = Grade.objects.get(name=GENERAL_MEMBER_GROUP),
                )
            User.coupon.objects.create(
                user_id =user.id,
                coupon=Coupon.objects.get(name='회원가입쿠폰'),
                validity=user.create_at+timedelta(days=365) # 회원가입이후 365일까지 사용가능한 쿠폰
            )
            return JsonResponse({'MESSAGE': 'SUCCESS TO MAKE ACCOUNT'}, status=201)


        except KeyError:
            return JsonResponse({'MESSAGE': 'KEY ERROR FOUND!'}, status=400)
        except ValueError:
            return JsonResponse({'MESSAGE': 'VALUE ERROR FOUND!'}, status=400)


class ProfileView(View):
    @login_required
    def get(self, request):
        LIMIT = 4
        user = request.user
        orders       = Order.objects.filter(user_id=user.id)\
                                           .values('status__name')\
                                           .annotate(count=Count('status'))

        recent_views =  RecentView.objects.filter(user=user)\
                                            .order_by('-create_at')\
                                            .distinct()[:LIMIT]       
        return JsonResponse({

            'userInfo'  : {
                'name': user.name,
                'grade': user.grade.name,
                'coupon': Coupon.objects.filter(user=user).count(),
                'point' : Point.objects.filter(user=user).order_by('create_at').first().remaining_point,
            },       

            'orderStatus':[{
                'name': order.get('status__name',None),
                'count': order.get('status__count',None),
            }for order in orders],

            'recentViews' : [{
                'name'      : i.product.name,
                'imageURL'  : i.product.image_url,
                'productId' : i.product.id,
            } for i in recent_view],
        })

