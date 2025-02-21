# -------- Stage 1: Build React Frontend --------
    FROM node:16-alpine as frontend-build
    WORKDIR /app/frontend
    
    # Copy package files and install dependencies
    COPY frontend/package*.json ./
    RUN npm install
    
    # Copy all source and build the React app
    COPY frontend/ ./
    RUN npm run build
    
    # -------- Stage 2: Build Django Backend --------
FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory to backend folder where manage.py lives
WORKDIR /app/backend

# Copy backend code and requirements
COPY backend/ .  
COPY requirements.txt ../requirements.txt  

RUN pip install --upgrade pip && pip install -r ../requirements.txt

# Copy the React build output into the Django project’s build directory
COPY --from=frontend-build /app/frontend/build ./build

# Collect static files
RUN python manage.py collectstatic --noinput

#EXPOSE 8000

#CMD ["gunicorn", "reactdoc.wsgi:application", "--bind", "0.0.0.0:8000"]

CMD gunicorn reactdoc.wsgi:application --bind 0.0.0.0:$PORT
