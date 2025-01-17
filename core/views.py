from django.shortcuts import render,redirect, get_object_or_404
from .models import * #asi llamamos a todos los models
from .forms import *
from django.contrib import messages
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.contrib.auth.decorators import login_required, user_passes_test
from .serializers import *
from rest_framework import viewsets
import requests
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import Group
from decimal import Decimal
from django.http import HttpResponse, JsonResponse
from django.db import transaction
from django.db.models import Q
import pandas as pd
from django.utils.dateparse import parse_date
from django.utils import timezone
from functools import wraps

#FUNCION GENERICA QUE VALIDA EL GRUPO DEL USUARIO

def grupo_requerido(*nombres_grupos):
    def check_grupo(user):
        return user.groups.filter(name__in=nombres_grupos).exists()

    def decorator(view_func):
        @wraps(view_func)
        def wrapper(request, *args, **kwargs):
            if check_grupo(request.user):
                return view_func(request, *args, **kwargs)
            else:
                return HttpResponse("No tienes permiso para acceder a esta página.")
        return wrapper
    return decorator

#@grupo_requerido('vendedor')
# CUANDO CREAN EN USUARIO LO ASIGNA INMEDIATAMENTE AL GRUPO
# grupo = Group.objects.get(name='usuario')
# user.groups.add(grupo)

#NOS PERMITE MOSTRAR LA INFO
class ProductoViewset(viewsets.ModelViewSet):
    queryset = Producto.objects.all()
    #queryset = Producto.objects.filter(tipo=1)
    serializer_class = ProductoSerializer

class TipoProductoViewset(viewsets.ModelViewSet):
    queryset = TipoProducto.objects.all()
    #queryset = Producto.objects.filter(tipo=1)
    serializer_class = TipoProductoSerializer

def index(request):

    productosAll = Producto.objects.all()

 
    query = request.GET.get('q')
    if query:
        productosAll = productosAll.filter(
            Q(Nombre__icontains=query) | Q(Descripcion__icontains=query)
        )

  
    page = request.GET.get('page', 1) 

    
    try:
        paginator = Paginator(productosAll, 12)
        productosAll = paginator.page(page)
    except:
        raise Http404

    data = {
        'listado': productosAll,
        'paginator': paginator
    }

    if request.method == 'POST':
        # Procesa la solicitud POST para agregar elementos al carrito, asumiendo que hay un modelo item_carrito definido
        Carrito = item_carrito()
        Carrito.Nombre = request.POST.get('nombre_producto')
        Carrito.precio = request.POST.get('precio_producto')
        Carrito.imagen = request.POST.get('imagen_producto')
        Carrito.save()
        
    return render(request, 'core/index.html', data)


@grupo_requerido('vendedor')
def CambiarGrupo(request):
    if request.method == 'POST':
        user_id = request.POST.get('user_id')
        group_name = request.POST.get('group_name')
        try:
            user = User.objects.get(id=user_id)
            group = Group.objects.get(name=group_name)
            user.groups.clear()
            user.groups.add(group)
        except User.DoesNotExist:
            pass
        except Group.DoesNotExist:
            pass
        return redirect('CambiarGrupo')

    users = User.objects.all()
    groups = Group.objects.all()

    data = {
        'users': users,
        'groups': groups,
    }

    return render(request, 'core/CambiarGrupo.html', data)

@grupo_requerido('vendedor')
def indexapi(request):
    #OBTIENE LOS DATOS DEL API
    respuesta = requests.get('http://127.0.0.1:8000/api/productos/')
    respuesta2 = requests.get('https://mindicador.cl/api')
    respuesta3 = requests.get('https://rickandmortyapi.com/api/character')
    #TRANSFORMAR EL JSON
    productos = respuesta.json()
    monedas = respuesta2.json()
    aux = respuesta3.json()
    personajes = aux['results']

    data = {
        'listado': productos,
        'monedas': monedas,
        'personajes':personajes,
    }

   
    return render(request,'core/indexapi.html', data)  


    

#CRUD

def Registrar(request):
    data = {
        'form': CustomUserCreationForm()
    }

    if request.method =='POST':
        formulario = CustomUserCreationForm(data=request.POST)
        if formulario.is_valid():
            formulario.save()
            user = authenticate(username=formulario.cleaned_data["username"], password=formulario.cleaned_data["password1"])
            grupo = Group.objects.get(name='cliente')
            user.groups.add(grupo)
            login(request, user)
            messages.success(request, "Te has registrado correctamente")
            return redirect(to="index")
        data["form"] = formulario

    return render(request, 'registration/Registrar.html', data)

def salir (request):
    logout(request)
    messages.success(request,F"Tu sesion se ha cerrado")
    return redirect(to="index")

@grupo_requerido('vendedor','bodeguero')
def add(request):
    data = {
        'form': ProductoForm(initial={'Fecha_creacion': timezone.now()})  # Establece la fecha actual como valor inicial
    }
    if request.method == 'POST':
        formulario = ProductoForm(request.POST, files=request.FILES)
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Producto almacenado correctamente")

    return render(request, 'core/add-product.html', data)




@grupo_requerido('vendedor','bodeguero')
def update(request, id):
    producto = get_object_or_404(Producto, id=id)  # Obtener un producto por su ID

    if request.method == 'POST':
        form = ProductoForm(request.POST, instance=producto)
        if form.is_valid():
            form.save()
            messages.success(request, "Producto actualizado correctamente")
            return redirect('index')
    else:
        form = ProductoForm(instance=producto)

    data = {
        'form': form,
    }

    return render(request, 'core/add-product.html', data)

@login_required
def delete(request,id):
    producto = Producto.objects.get(id=id) #OBTIENE UN PRODUCTO POR EL ID
    producto.delete()

    return redirect(to='index')



@login_required
def agregar_al_carrito(request, producto_id):
    # Obtener el usuario actualmente autenticado
    usuario = request.user
    
    # Obtener el producto utilizando su ID
    producto = Producto.objects.get(id=producto_id)
    
    # Verificar si el producto ya está en el carrito del usuario
    carrito_existente = item_carrito.objects.filter(usuario=usuario, producto=producto).first()
    
    if carrito_existente:
        # Si el producto ya está en el carrito, se incrementa la cantidad
        carrito_existente.items += 1
        carrito_existente.save()
    else:
        # Si el producto no está en el carrito, se crea un nuevo registro
        nuevo_item = item_carrito(usuario=usuario, producto=producto, items=1)
        nuevo_item.save()
    # Actualizar el stock del producto
    producto.Stock -= 1
    producto.save()
    
    # Retornar un mensaje de éxito
    return redirect(request.META['HTTP_REFERER'])



@login_required
def actualizar_carrito(request):
    if request.method == 'POST':
        item_id = request.POST.get('item_id')
        cantidad = int(request.POST.get('cantidad'))
        
        # Actualizar la cantidad del producto en el carrito
        try:
            item = item_carrito.objects.get(id=item_id)
            producto = item.producto
            stock_actual =int(producto.Stock)
            if cantidad > stock_actual:
                messages.error(request, 'No hay suficiente stock disponible.')
            else:
                # Calcular la diferencia de stock
                diferencia_stock = cantidad - item.items
                item.items = cantidad
                item.save()
                producto.Stock = stock_actual - diferencia_stock
                producto.save()


            messages.success(request, 'El carrito se ha actualizado correctamente.')
        except item_carrito.DoesNotExist:
            messages.error(request, 'El producto no existe en el carrito.')
        
        return redirect(request.META['HTTP_REFERER'])

    return redirect('core/Carrito.html') 

@login_required
def Carrito(request):
    # Obtener los productos en el carrito del usuario actual
    items = item_carrito.objects.filter(usuario=request.user)

    # Obtener el valor del dólar desde la API de Mindicador
    respuesta = requests.get('https://mindicador.cl/api/dolar').json()
    valor_usd = respuesta['serie'][0]['valor']

    # Calcular el precio total de cada producto en CLP y USD
    for item in items:
        item.precio_total = item.items * item.producto.precio
        item.precio_total_usd = item.precio_total / valor_usd

    # Calcular el precio total del carrito en CLP y USD
    precio_total = sum(item.precio_total for item in items)
    precio_total_usd = round(sum(item.precio_total_usd for item in items), 2)

    # Pasar los productos, precios totales en CLP y USD al template como parte del contexto
    data = {
        'items': items,
        'precio_total': precio_total,
        'precio_total_usd': precio_total_usd,
        # Otros datos que ya tienes en tu vista...
    }

    return render(request, 'core/Carrito.html', data)

@login_required
def eliminarCarro(request, id):
    carrito = item_carrito.objects.get(id=id)
    
    # Obtener el producto del carrito
    producto = carrito.producto
    
    # Incrementar el stock del producto
    producto.Stock += carrito.items
    producto.save()
    
    # Eliminar el registro del carrito
    carrito.delete()
    
    return redirect("Carrito")


def Contact(request):
    return render(request,'core/Contact.html')
    



def team(request):
    productosAll = Producto.objects.all()#SELECT * FROM producto
    page = request.GET.get('page', 1) # OBTENEMOS LA VARIABLE DE LA URL, SI NO EXISTE NADA DEVUELVE 1ç

    
    try:
        paginator = Paginator(productosAll, 9)
        productosAll = paginator.page(page)
    except:
        raise Http404

    data = {
        'listado': productosAll,
        'paginator': paginator
    }

    if request.method == 'POST':
        Carrito = item_carrito()
        Carrito.Nombre = request.POST.get('nombre_producto')
        Carrito.precio = request.POST.get('precio_producto')
        Carrito.imagen = request.POST.get('imagen_producto')
        Carrito.save()

    return render(request,'core/team.html', data)

    ##suscripcion
@grupo_requerido('cliente')
def suscripcion(request):
    primer_nivel = TipoSuscripcion.objects.get(id=1)
    segundo_nivel = TipoSuscripcion.objects.get(id=2)
    tercer_nivel = TipoSuscripcion.objects.get(id=3)
    
    try:
        suscripcionUsuario = Suscripcion.objects.filter(usuario=request.user).first()
    except Suscripcion.DoesNotExist:
        suscripcionUsuario = None

    data = {
        'primer_nivel': primer_nivel,
        'segundo_nivel': segundo_nivel,
        'tercer_nivel' : tercer_nivel,
        'suscripcionUsuario'  : suscripcionUsuario,
    }
    
    respuesta = requests.get('https://mindicador.cl/api/dolar').json()
    valor_usd = respuesta['serie'][0]['valor']

    precios = {
        'primer_nivel': primer_nivel.precio,
        'segundo_nivel': segundo_nivel.precio,
        'tercer_nivel': tercer_nivel.precio
    }
    
    valor_suscripcion = precios['segundo_nivel']  # Obtén el precio del primer nivel, puedes cambiarlo según tus necesidades
    valor_total = valor_suscripcion / valor_usd

    data['valor'] = round(valor_total, 2)
    
    return render(request, 'core/suscripcion.html', data)



def suscripcionAdmin(request):
    primer_nivel= TipoSuscripcion.objects.get(id=1)
    segundo_nivel = TipoSuscripcion.objects.get(id=2)
    tercer_nivel = TipoSuscripcion.objects.get(id=3)
    
    try:
        suscripcionUsuario = Suscripcion.objects.filter(usuario=request.user).first()
    except Suscripcion.DoesNotExist:
        suscripcionUsuario = None

    data = {
        'primer_nivel': primer_nivel,
        'segundo_nivel': segundo_nivel,
        'tercer_nivel' : tercer_nivel,
        'suscripcionUsuario'  : suscripcionUsuario.usuario.username if suscripcionUsuario else None

    }
    return render(request, 'core/suscripcionAdmin.html', data)

####### CRUD Suscripciones#############
@grupo_requerido('vendedor')
def addSuscripcion(request, id):
    usuario = request.user
    tipoSuscripcion = TipoSuscripcion.objects.get(id=id)
    suscripcionUsuario = Suscripcion.objects.create(usuario=usuario, suscripcion=tipoSuscripcion)
    return redirect('suscripcion')

@grupo_requerido('vendedor')
def deleteSuscripcion(request, id):
    suscripcionUsuario = Suscripcion.objects.filter(usuario=request.user).first()
    if suscripcionUsuario:
        suscripcionUsuario.delete()
    return redirect('suscripcion')

@grupo_requerido('vendedor')
def updateSuscripcion(request, id):
    suscripcionUsuario = Suscripcion.objects.filter(usuario=request.user).first()
    if suscripcionUsuario:
        tipoSuscripcion = TipoSuscripcion.objects.get(id=id)
        suscripcionUsuario.suscripcion = tipoSuscripcion
        suscripcionUsuario.save()
    return redirect('suscripcion')
####################FIN ############

def suscribirse(request):

    return render(request, 'core/suscribirse.html')


@login_required
def Finalcompra(request):
    carrito_items = item_carrito.objects.all()

    with transaction.atomic():
        # Crear una compra y asignarle un código
        historial = HistorialCompra.objects.create()
        historial.codigo = generar_codigo()
        historial.save()

        # Guardar los elementos del carrito en la tabla HistorialCompra
        for item in carrito_items:
            pedido = Pedido(
                usuario=item.usuario,
                producto=item.producto,
                items=item.items,
                precio_total=item.items * item.producto.precio
            )
            pedido.save()
            historial.compra.add(pedido)

    # Eliminar los elementos del carrito
    carrito_items.delete()

    return render(request,'core/Carrito.html')   



def FinalSuscripcion(request):

    return render(request,'core/index.html')    

        

def Pagar_suscripcion(request):

    return render(request,'core/Pagar_suscripcion.html')

#Variables para susc
def Varisus(request):



    data = {
        'variable': variable,
    }

    return render(request, 'core/team.html', data)

@login_required
def historial(request):
    # Obtener el historial de compras del usuario actual
    pedidos = Pedido.objects.filter(usuario=request.user)
    historiales = HistorialCompra.objects.filter(compra__in=pedidos).distinct()

    # Pasar el historial de compras al contexto de la plantilla
    data = {
        'historiales': historiales
    }

    return render(request, 'core/historial.html', data)

@grupo_requerido('vendedor','bodeguero')
def seguimiento(request):
    pedidos = Pedido.objects.all().select_related('usuario', 'producto')
    usuarios = User.objects.all() 

    nombre_usuario = request.GET.get('usuario')

    if nombre_usuario:
        pedidos = pedidos.filter(usuario__username=nombre_usuario)

    data = {
        'pedidos': pedidos,
        'usuarios': usuarios,
        'nombre_usuario': nombre_usuario
    }

    return render(request, 'core/seguimiento.html', data)


@grupo_requerido('bodeguero')
def cambiar_estado_pedido(request, pedido_id):
    # Obtener el pedido específico
    pedido = Pedido.objects.get(pk=pedido_id)

    if request.method == 'POST':
        # Obtener el nuevo estado seleccionado
        nuevo_estado = request.POST.get('nuevo_estado')

        # Actualizar el estado del pedido
        pedido.estado = nuevo_estado
        pedido.save()
        return redirect('seguimiento')
    return render(request, 'core/seguimiento.html', {'pedido': pedido})

@grupo_requerido('contador')
def ReporteVentas(request):

    fecha_inicio_str = request.GET.get('fecha_inicio')
    fecha_fin_str = request.GET.get('fecha_fin')


    fecha_inicio = parse_date(fecha_inicio_str)
    fecha_fin = parse_date(fecha_fin_str)


    pedidos = Pedido.objects.filter(fecha_compra__date__range=[fecha_inicio, fecha_fin])


    data = []
    for pedido in pedidos:
        data.append({
            'Usuario': pedido.usuario.username,
            'Producto': pedido.producto.Nombre,
            'Items': pedido.items,
            'Precio Total': pedido.precio_total,
            'Fecha de Compra': pedido.fecha_compra,
            'Estado': pedido.estado,
        })

    df = pd.DataFrame(data)


    if not df.empty:
        df['Fecha de Compra'] = pd.to_datetime(df['Fecha de Compra']).dt.tz_localize(None)


    response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    response['Content-Disposition'] = 'attachment; filename="Reporte de ventas FERREMAS.xlsx"'
    df.to_excel(response, index=False, engine='openpyxl')

    return response


@login_required
def perfil(request):
    if request.method == 'POST':
        form = UserProfileForm(request.POST, instance=request.user)
        if form.is_valid():
            form.save()
            return redirect('index')  
    else:
        form = UserProfileForm(instance=request.user)
    return render(request, 'core/perfil.html', {'form': form})


@login_required
def PagarCarrito(request):
    usuario = request.user
    items = item_carrito.objects.filter(usuario=usuario)
    precio_total = sum(item.producto.precio * item.items for item in items)
    cantidad_total = sum(item.items for item in items)  # Calcular la cantidad total de productos

    respuesta = requests.get('https://mindicador.cl/api/dolar').json()
    valor_usd = respuesta['serie'][0]['valor']

    valor_Carrito = precio_total
    valor_total = valor_Carrito / valor_usd

    # Filtrar solicitudes no autorizadas del usuario
    solicitudes = SolicitudPago.objects.filter(usuario=usuario, autorizado=False, compra_completada=False)

    if solicitudes.exists():
        solicitud_pago = solicitudes.first()
        solicitud_pago.precio_total = precio_total
        solicitud_pago.valor_total = valor_total
        solicitud_pago.items = cantidad_total
        solicitud_pago.save()
    else:
        solicitud_pago = SolicitudPago.objects.create(
            usuario=usuario,
            precio_total=precio_total,
            valor_total=valor_total,
            items=cantidad_total,
            autorizado=False,
            compra_completada=False,
        )

    data = {
        'listaCarrito': items,
        'precio_total': precio_total,
        'valor': round(valor_total, 2),
        'solicitud_pago': solicitud_pago,
    }

    return render(request, 'core/PagarCarrito.html', data)


@login_required
def Pagar(request):
    usuario = request.user
    items = item_carrito.objects.filter(usuario=usuario)
    precio_total = sum(item.producto.precio * item.items for item in items)
    cantidad_total = sum(item.items for item in items)  # Calcular la cantidad total de productos

    respuesta = requests.get('https://mindicador.cl/api/dolar').json()
    valor_usd = respuesta['serie'][0]['valor']

    valor_Carrito = precio_total
    valor_total = valor_Carrito / valor_usd

    # Filtrar solicitudes no autorizadas del usuario
    solicitudes = SolicitudPago.objects.filter(usuario=usuario, autorizado=False, compra_completada=False)

    if solicitudes.exists():
        solicitud_pago = solicitudes.first()
        solicitud_pago.precio_total = precio_total
        solicitud_pago.valor_total = valor_total
        solicitud_pago.items = cantidad_total
        solicitud_pago.save()
    else:
        solicitud_pago = SolicitudPago.objects.create(
            usuario=usuario,
            precio_total=precio_total,
            valor_total=valor_total,
            items=cantidad_total,
            autorizado=False,
            compra_completada=False,
        )

    data = {
        'listaCarrito': items,
        'precio_total': precio_total,
        'valor': round(valor_total, 2),
        'solicitud_pago': solicitud_pago,
    }

    return render(request, 'core/Pagar.html', data)



def es_vendedor(usuario):
    return usuario.groups.filter(name='vendedor').exists()

@grupo_requerido('vendedor','bodeguero')
def AutorizarPago(request, solicitud_id):
    solicitud = get_object_or_404(SolicitudPago, id=solicitud_id)
    if request.method == 'POST':
        solicitud.autorizado = True
        solicitud.save()
        return redirect('listar_solicitudes_pago')
    return render(request, 'core/AutorizarPago.html', {'solicitud': solicitud})

@grupo_requerido('vendedor','bodeguero')
def ListarSolicitudesPago(request):
    solicitudes_pendientes = SolicitudPago.objects.filter(autorizado=False).prefetch_related('usuario')

    # Para cada solicitud, obtener los productos y cantidades con sus tipos
    for solicitud in solicitudes_pendientes:
        items = item_carrito.objects.filter(usuario=solicitud.usuario).select_related('producto')
        productos = {}
        for item in items:
            producto_nombre = item.producto.Nombre
            producto_tipo = item.producto.tipo.descripcion
            if producto_nombre in productos:
                productos[producto_nombre]['cantidad'] += item.items
            else:
                productos[producto_nombre] = {
                    'cantidad': item.items,
                    'tipo': producto_tipo
                }
        solicitud.productos = productos

    return render(request, 'core/ListarSolicitudesPago.html', {'solicitudes': solicitudes_pendientes})




def CompletarCompra(request, solicitud_id):
    solicitud_pago = get_object_or_404(SolicitudPago, id=solicitud_id)

    if not solicitud_pago.autorizado:

        pass

    return render(request, 'completar_compra.html', {'solicitud_pago': solicitud_pago})

def pagina_autorizacion_exitosa(request):
    return render(request, 'core/PaginaAutorizacionExitosa.html')

def pagina_compra_exitosa(request):
    return render(request, 'core/PaginaCompraExitosa.html')

@grupo_requerido('vendedor','bodeguero')
def verificar_autorizacion(request, solicitud_id):
    solicitud = get_object_or_404(SolicitudPago, id=solicitud_id)
    data = {
        'autorizado': solicitud.autorizado
    }
    return JsonResponse(data)

@grupo_requerido('vendedor','bodeguero')
def RechazarPago(request, solicitud_id):
    solicitud = get_object_or_404(SolicitudPago, id=solicitud_id)
    if request.method == 'POST':
        solicitud.delete()  # Eliminar la solicitud
        return redirect('listar_solicitudes_pago')  # Redirigir a la lista de solicitudes de pago
    return render(request, 'core/rechazar_pago.html', {'solicitud': solicitud})


