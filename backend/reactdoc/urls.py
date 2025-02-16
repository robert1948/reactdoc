from django.contrib import admin
from django.urls import path, re_path
from django.views.generic import TemplateView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    # Add your API endpoints here if using Django REST Framework
]

# Serve React frontend for all other routes
urlpatterns += [
    re_path(r'^.*', TemplateView.as_view(template_name='index.html')),
]

# Serve static files
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)