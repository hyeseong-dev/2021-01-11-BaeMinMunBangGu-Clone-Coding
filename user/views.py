import bcrypt
import json
import jwt
import re

from django.http    import JsonResponse
from django.views   import View
from datetime       import datetime, timedelta

from user.models    import User
from decorators     import utils
from my_settings    import SECRET_KEY, ALGORITHM


class SignUpView(View):
    def post(self, request):
        try:
            data     = json.loads(request.body)
            account  = data['account']
            password = data['password']
            name     = data['name']
            email    = data['email']
            phone    = data['phone']

            if not utils.account_validation(account): 
                return JsonResponse({"MESSAGE":'NOT VALID ACCOUNT'}, status=400)

            if utils.password_check(password)!=True:
                return utils.password_check(password)

            if not utils.email_validation(email):
                return JsonResponse({"MESSAGE":'NOT VALID EMAIL'}, status=400)

            if not utils.username_validation(name):
                return JsonResponse({"MESSAGE":'NOT VALID NAME'}, status=400)

            if not utils.phone_validation(phone):
                return JsonResponse({"MESSAGE":'NOT VALID PHONE'}, status=400)
            
            if utils.check_duplication(account=account,email=email, phone=phone): 
                return JsonResponse({'MESSAGE': 'INFORMATION REGISTERED ALREADY!'}, status=409)

            hash_pwd = bcrypt.hashpw(password.encode('utf-8'),bcrypt.gensalt()).decode() 

            User.objects.create(
                account =account,
                password=hash_pwd,
                name    =name,
                email   =email,
                phone   =phone

            )
            return JsonResponse({'MESSAGE': 'SUCCESS TO MAKE ACCOUNT'}, status=201)

        except KeyError:
            return JsonResponse({'MESSAGE': 'KEY ERROR FOUND!'}, status=400)
        except ValueError:
            return JsonResponse({'MESSAGE': 'VALUE ERROR FOUND!'}, status=400)

class LoginView(View):
    def post(self, request):
        try:
            data        = json.loads(request.body)
            password    = data['password']
            
            if not signup_db.filter(account=data['account']).exists():
                return JsonResponse({'MESSAGE':'ACCOUNT NOT FOUND'}, status=404)

            if signup_db.filter(account = data['account']).exists():
                login_id = User.objects.get(account = data['account'])

                if bcrypt.checkpw(password.encode('utf-8'), login_id.password.encode('utf-8')):
                    user_token = jwt.encode({'user_id': login_id.id}, SECRET_KEY, algorithm=ALGORITHM)
                    return JsonResponse({'MESSAGE':'SUCCESS','TOKEN':user_token}, status=200, safe=True)
                return JsonResponse({'MESSAGE':'INVALID ACCOUNT'}, status= 401)

        except KeyError :
            return JsonResponse({'MESSAGE':'KEY ERROR'}, status=400)
        except ValueError:
            return JsonResponse({'MESSAGE':'VALUE ERROR'},status=400)
