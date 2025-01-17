from django.contrib import admin
from .models import *
# Register your models here.
#Modo tabla la visualizacion del admin

class ProductoAdmin(admin.ModelAdmin):
    list_display = ['Nombre','precio','Stock','Descripcion','tipo']
    search_fields=['Nombre']
    list_per_page=10
    list_filter =['tipo','precio'] #filtrar por tipos
    list_editable =['precio','Stock','Descripcion','tipo']

class SuscripcionAdmin(admin.ModelAdmin):
    list_display = ['usuario','suscripcion']

    list_per_page = 10
    list_filter = ['usuario']
    list_editable = ['suscripcion']

class TipoSuscripcionAdmin(admin.ModelAdmin):
    list_display = ['nombre','precio']

    list_per_page = 10

    list_editable = ['precio']
    list_display_links = ['nombre']

admin.site.register(TipoProducto)
admin.site.register(Producto,ProductoAdmin)
admin.site.register(item_carrito)
admin.site.register(Suscripcion,SuscripcionAdmin)
admin.site.register(TipoSuscripcion,TipoSuscripcionAdmin)


