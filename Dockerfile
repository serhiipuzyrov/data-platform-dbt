FROM python:3.12-slim

WORKDIR /

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .
COPY .dbt/profiles.yml /.dbt/profiles.yml

# Set default environment variables
ENV DBT_PROFILES_DIR=/.dbt

# Run all dbt commands in order
CMD dbt deps && \
    dbt source freshness --target ${DBT_TARGET:-dev} && \
    dbt build --target ${DBT_TARGET:-dev}