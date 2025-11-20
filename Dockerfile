# Use a lightweight Python base image
FROM python:3.10-slim

# Set working directory inside the container
WORKDIR /app

# Copy Flask app into the container
COPY scripts/hello.py .

# Install Flask
RUN pip install flask

# Expose port 5000 for the Flask app
EXPOSE 5000

# Run the app
CMD ["python", "hello.py"]
