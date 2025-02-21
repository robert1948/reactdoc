from django.contrib import admin
from django.urls import path, re_path
from django.views.generic import TemplateView

urlpatterns = [
    path('admin/', admin.site.urls),
    # Include your API routes here, for example:
    # path('api/', include('api.urls')),

    # Catch-all: send all unmatched URLs to React’s index.html
    re_path(r'^.*$', TemplateView.as_view(template_name='index.html')),
]
