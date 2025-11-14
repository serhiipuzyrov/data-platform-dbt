FROM python:3.12-slim

WORKDIR /app

# Copy requirements for the docs app
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy static docs (already copied here by GitHub Actions)
COPY static/ ./static/

# Copy the Flask app
COPY app.py .

# Expose port
EXPOSE 8080

# Run the app
CMD ["python", "app.py"]