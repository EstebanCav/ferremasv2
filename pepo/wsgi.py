<<<<<<< HEAD
"""
WSGI config for pepo project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.2/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'pepo.settings')

application = get_wsgi_application()
=======
"""
WSGI config for pepo project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.2/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'pepo.settings')

app = get_wsgi_application()
>>>>>>> 7337a6a4760bbed13ad3b5f103e5c213ad06b5df
