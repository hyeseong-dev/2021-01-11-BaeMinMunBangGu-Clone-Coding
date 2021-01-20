# Generated by Django 3.1.5 on 2021-01-20 04:19

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0002_auto_20210114_1804'),
        ('product', '0004_auto_20210118_1710'),
        ('order', '0002_auto_20210114_0039'),
    ]

    operations = [
        migrations.CreateModel(
            name='Cart',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('total_price', models.DecimalField(decimal_places=2, max_digits=18)),
                ('quantity', models.IntegerField(default=1)),
                ('address', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='carts', to='user.address')),
            ],
            options={
                'db_table': 'carts',
            },
        ),
        migrations.RemoveField(
            model_name='order',
            name='update_at',
        ),
        migrations.RemoveField(
            model_name='orderstatus',
            name='order_id',
        ),
        migrations.AlterField(
            model_name='order',
            name='order_status',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='carts', to='order.orderstatus'),
        ),
        migrations.AlterField(
            model_name='order',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='carts', to='user.user'),
        ),
        migrations.DeleteModel(
            name='OrderItem',
        ),
        migrations.AddField(
            model_name='cart',
            name='order',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='carts', to='order.order'),
        ),
        migrations.AddField(
            model_name='cart',
            name='product',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='carts', to='product.product'),
        ),
        migrations.AddField(
            model_name='cart',
            name='thumbnail',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='cart', to='product.product'),
        ),
    ]
