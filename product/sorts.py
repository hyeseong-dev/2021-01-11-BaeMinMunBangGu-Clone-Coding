from product.models import Product

def is_new(create_at, compare_date):
    return create_at > compare_date 

def check_best_items():
    best_items = Product.objects.all().order_by('total_sales')[:20]
    list_ = []
    for best in best_items:
        list_.append(best.id)
    return list_

def is_best(checkList, arg):
    return arg in checkList 

def is_sale(sale):
    return sale > 0 
    