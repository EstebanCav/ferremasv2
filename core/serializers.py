#NOS VA A PERMITIR CONVERTIR LA DATA JOJOJOJOJOJOJOJOJOJOJJOJ
from .models import *
from rest_framework import serializers

class TipoProductoSerializer(serializers.ModelSerializer):
    class Meta:
        model = TipoProducto
        fields ='__all__'


class ProductoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Producto
        fields = '__all__'



class TipoSuscripcionSerializer(serializers.ModelSerializer):
    class Meta:
        model = TipoSuscripcion
        fields ='__all__'



class SuscripcionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Suscripcion
        fields ='__all__'

