import jwt
import json
import re

from django.http import JsonResponse
from django.db.models import Q

from user.models import User

from my_settings import ALGORITHM, SECRET_KEY
from decorators  import utils

def check_duplication(account, email,phone):
    return User.objects.filter(Q(account=account) | 
                               Q(email=email) | 
                               Q(phone=phone)).exists()

def account_validation(account):
    REGEX_ACCOUNT = '(?i)^(?=.*[a-z])[a-z0-9]{4,20}$'
    if not re.search(REGEX_ACCOUNT, account):
        return False
    return True

def email_validation(email):
    REGEX_EMAIL = '^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    if not re.search(REGEX_EMAIL, email):
        return False
    return True

def username_validation(name):
    REGEX_KOREAN = ('^[가-힣]')
    if not re.search(REGEX_KOREAN, name):
        return False
    return True

def phone_validation(phone):
    if len(phone) != 11:
        return False
    return True


def password_check(password):
    if len(password)<8 and len(password)>=16:
        return JsonResponse({'MESSAGE':' PASSWORD SHOULD BE OVER 8 AND UNDER 17 '}, status=412)
    
    if not re.findall('[0-9]',password) and (not re.findall('[a-z]',password) or not re.findall('[A-Z]',password)):
        return JsonResponse({'MESSAGE':'PASSWORD SHOULD BE ONLY ALPHABET AND DIGITS .'}, status=412)
    
    if re.search('[@$!%*#?&]+', password) is None:
        return JsonResponse({'MESSAGE':'비밀 번호는 1개 이상의 특수문자(@$!%*#?&)를 포함해야합니다.'}, status=412)
    
    return True

def login_required(func):
    def wrapper(self, request, *args, **kwargs):
        try:
            access_token = request.headers['Authorization']
            payload      = jwt.decode(access_token, SECRET_KEY, algorithms=ALGORITHM) 
            user         = User.object.get(id=payload['user_pk'])
            request.user = user
        except jwt.DecodeError:
            return JsonResponse({'MESSAGE':'JWT_DECODE_ERROR'}, status=400)
        except TypeError:
            return JsonResponse({"MESSAGE":"LOGIN_REQUIRED"}, status = 401)
        except User.DoesNotExist:
            return JsonResponse({"MESSAGE":"USER_DOES_NOT_EXIST"}, status = 401)
        return func(request, *args, **kwargs)
    return wrapper