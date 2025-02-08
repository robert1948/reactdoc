# First stage: Build React frontend
FROM node:16 AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# Second stage: Set up Django backend
FROM python:3.9-slim
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create a non-root user
RUN useradd -m myuser
WORKDIR /app

# Install build dependencies as root
RUN apt-get update && apt-get install -y gcc

# Copy requirements and backend files as root
COPY requirements.txt .
COPY backend/ ./backend/
COPY --from=frontend-builder /app/frontend/build/ ./backend/static/

# Change ownership of all files to myuser
RUN chown -R myuser:myuser /app

# Switch to non-root user
USER myuser

# Install Python dependencies as non-root user
RUN pip install --user --upgrade pip
RUN pip install --user -r requirements.txt

WORKDIR /app/backend

# Run collectstatic as non-root user
RUN python manage.py collectstatic --noinput --verbosity 3

# Expose the port (if needed, e.g., for development)
#EXPOSE 8000

# Command to run the application (adjust based on your deployment needs)
#CMD ["gunicorn", "backend.wsgi:application", "--bind", "0.0.0.0:8000"]
CMD ["gunicorn", "backend.wsgi:application", "--bind", "0.0.0.0:$PORT"]