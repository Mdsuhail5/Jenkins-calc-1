
# Use Python 3.10 as the base image
FROM python:3.10-slim

# Set working directory inside the container
WORKDIR /app

# Copy dependency list
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Run the application when container starts
CMD ["python", "app.py"]