from django.utils       import timezone

from product.models     import MatchingReview
from order.models       import Order


def get_order_list(request):
    compare_date = timezone.localtime() - timedelta(days=7)
    user         = request.user
    start_date   = request.GET.get('startDate', compare_date)
    end_date     = request.GET.get('endDate', timezone.localtime())

    orders = Order.objects.filter(\
                user_id=user.id,\
                create_at__range=(start_date, end_date))

    result = [{
        'serialNumber' : order.serial_number,
        'orderStatus'  : order.status.id,
        'orderDate'    : order.create_at,
        'orderId'      : order.id,
        'products'  : [{
            'id'            : cart.product.id,
            'name'          : cart.product.name,
            'totalPrice'    : cart.total_price,
            'quantity'      : cart.quantity,
            'status' : cart.status.id,
            'isReview'      : MatchingReview.objects.filter(order=order.id, product=cart.product).exists()
        }for cart in order.cart_set.all()]
    }for order in orders]

    return result