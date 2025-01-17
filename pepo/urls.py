from django.contrib import admin
from django.urls import include, path
from django.conf import settings
from django.conf.urls.static import static
from django.http import HttpResponse  # Agregar esta importación

def favicon_view(request):
    return HttpResponse(status=204)

urlpatterns = [
    path('', include('core.urls')),
    path('admin/', admin.site.urls),
    path('accounts/', include('django.contrib.auth.urls')),
    path('favicon.ico', favicon_view),
]
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

admin.site.site_title = "PerriPapitos"
admin.site.site_header = "Administracion de la Mascoteria"
admin.site.index_title = "Modulo de Administracion"
