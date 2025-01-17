from django import forms
from django.forms import ModelForm
from .models import *
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User

class SeguimientoPedidoForm(forms.ModelForm):
    class Meta:
        model = Pedido
        fields = ['estado']

class ProductoForm(ModelForm):
    Nombre = forms.CharField(widget=forms.TextInput(attrs={"placeholder":"Ingrese Nombre"}))
    precio = forms.DecimalField(min_value=0.01, widget=forms.NumberInput(attrs={"placeholder":"Ingrese Precio"}))
    Stock = forms.IntegerField(min_value=1, widget=forms.NumberInput(attrs={"placeholder":"Ingrese Stock"}))
    Descripcion = forms.CharField(min_length=10, max_length=200, widget=forms.Textarea(attrs={"rows":4}))

    class Meta:
        model = Producto
        fields = '__all__'
        widgets = {
            'Fecha_creacion' : forms.SelectDateWidget(years=range(1940, 2024))
        }
    helper = FormHelper() 
    helper.add_input(Submit('submit', 'Guardar')) 

class CarriForm(forms.ModelForm):
    class Meta:
        model = item_carrito
        fields = ['producto', 'items']

class CustomUserCreationForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['username','first_name','last_name','email','password1','password2']

class UserProfileForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['username', 'first_name', 'last_name', 'email']  # Campos del usuario que se pueden editar