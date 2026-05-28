# Base image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Create a non-root user and group
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Ensure ownership of /app is set to appuser
RUN chown -R appuser:appuser /app

# Switch to appuser
USER appuser

# Expose port 8000
EXPOSE 8000

# CMD to run the application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
