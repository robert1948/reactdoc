# --- Stage 1: Build React frontend ---
    FROM node:16 as frontend-builder
    WORKDIR /app/frontend
    # Copy package files and install dependencies
    COPY frontend/package*.json ./
    RUN npm install
    # Copy the rest of the React app source code and build it
    COPY frontend/ ./
    RUN npm run build
    
    # --- Stage 2: Setup Django backend ---
    FROM python:3.9-slim
    ENV PYTHONDONTWRITEBYTECODE=1
    ENV PYTHONUNBUFFERED=1
    
    WORKDIR /app
    
    # Install system dependencies
    RUN apt-get update && apt-get install -y gcc
    
    # Copy and install Python dependencies
    COPY requirements.txt .
    RUN pip install --upgrade pip
    RUN pip install -r requirements.txt
    
    # Copy Django backend code
    COPY backend/ ./backend/
    
    # Copy React build from stage 1 into Django's static folder.
    # Here we assume that the static files should live in backend/static/.
    # (Ensure that STATIC_ROOT in Django settings is set accordingly.)
    COPY --from=frontend-builder /app/frontend/build/ ./backend/static/
    
    # Set the working directory to the Django project folder
    WORKDIR /app/backend
    
    # Collect static files with increased verbosity for debugging
    RUN python manage.py collectstatic --noinput --verbosity 3
    
    # Expose the port (Heroku sets the PORT env variable)
    EXPOSE 8000
    
    # Command to run Gunicorn serving the Django app.
    CMD gunicorn reactdoc.wsgi:application --bind 0.0.0.0:${PORT:-8000}
    