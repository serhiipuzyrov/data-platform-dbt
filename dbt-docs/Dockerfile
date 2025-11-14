FROM python:3.12-slim

WORKDIR /

# Install Flask
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy static docs (will be injected by CI/CD)
COPY dbt-docs dbt-docs

# Copy the server
COPY server.py server.py

EXPOSE 8080

CMD ["python", "server.py"]