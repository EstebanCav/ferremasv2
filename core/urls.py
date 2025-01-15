from django.urls import path, include
from.views import *
from rest_framework import routers
from django.contrib.auth import views as auth_views
from . import views

#Creamos las rutas del api
router = routers.DefaultRouter()
router.register('productos',ProductoViewset)
router.register('tipoproductos',TipoProductoViewset)



urlpatterns = [
    #API
    path('api/', include(router.urls)),
    #RUTAS
    path('Carrito/',Carrito, name="Carrito"),
    path('Contact/',Contact, name="Contact"),
    path('',index, name="index"),
    path('indexapi',indexapi, name="indexapi"),
    path('team/',team, name="team"),

    path('PagarCarrito/', PagarCarrito, name='PagarCarrito'),
    path('pagar/', Pagar, name='pagar'),
    path('AutorizarPago/<int:solicitud_id>/', AutorizarPago, name='AutorizarPago'),
    path('listar_solicitudes_pago/', ListarSolicitudesPago, name='listar_solicitudes_pago'),
    path('completar_compra/<int:solicitud_id>/', CompletarCompra, name='completar_compra'),
    path('autorizacion_exitosa/', pagina_autorizacion_exitosa, name='pagina_autorizacion_exitosa'),
    path('compra_exitosa/', pagina_compra_exitosa, name='pagina_compra_exitosa'),
    path('verificar_autorizacion/<int:solicitud_id>/', verificar_autorizacion, name='verificar_autorizacion'),
    path('rechazar_pago/<int:solicitud_id>/', views.RechazarPago, name='RechazarPago'),


    path('suscripcion/',suscripcion,name='suscripcion'),
    path('suscribirse/',suscribirse,name='suscribirse'),
    path('Finalcompra/',Finalcompra,name='Finalcompra'),
    path('FinalSuscripcion/',FinalSuscripcion,name='FinalSuscripcion'),
    path('suscripcionAdmin/',suscripcionAdmin,name='suscripcionAdmin'),
    path('agregar_al_carrito/<int:producto_id>/', agregar_al_carrito, name='agregar_al_carrito'),
    path('historial/', historial,name='historial'),
    path('cambiar_estado/<int:pedido_id>/', cambiar_estado_pedido, name='cambiar_estado_pedido'),
    path('seguimiento/', seguimiento, name='seguimiento'),
    path('CambiarGrupo/', CambiarGrupo, name='CambiarGrupo'),
    path('ReporteVentas/', ReporteVentas, name='ReporteVentas'),
    path('perfil/', views.perfil, name='perfil'),


    #Restablecer contraseña
    path('password_reset/', auth_views.PasswordResetView.as_view(template_name='password_reset_form.html'), name='password_reset'),
    path('password_reset_done/', auth_views.PasswordResetDoneView.as_view(template_name='password_reset_done.html'), name='password_reset_done'),
    path('password_reset_confirm/uidb64/token/',auth_views.PasswordResetConfirmView.as_view(template_name='password_reset_confirm.html'), name='password_reset_confirm'),
    path('password_reset_complete/', auth_views.PasswordResetCompleteView.as_view(template_name='password_reset_complete.html'), name='password_reset_complete'),

    #crud
    path('Registrar/',Registrar, name="Registrar"),
    path('add/',add, name="add"),
    path('update/<id>/',update, name="update"),
    path('delete/<id>/',delete, name="delete"),
    path('eliminarCarro/<id>/',eliminarCarro, name="eliminarCarro"),
    path('actualizar_carrito/', actualizar_carrito, name='actualizar_carrito'),
    path('Pagar_suscripcion/', Pagar_suscripcion, name='Pagar_suscripcion'),
    path('addSuscripcion/<id>/', addSuscripcion, name='addSuscripcion'),
    path('deleteSuscripcion/<id>/', deleteSuscripcion, name='deleteSuscripcion'),
    path('updateSuscripcion/<id>/',updateSuscripcion,name='updateSuscripcion'),
    path('salir/', salir, name='salir'),
    

    
    



    

]
