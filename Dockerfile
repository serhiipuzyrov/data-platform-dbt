FROM python:3.12-slim

WORKDIR /

# Install gcloud CLI properly
#RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y curl apt-transport-https ca-certificates gnupg git && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    apt-get update && apt-get install -y google-cloud-sdk && \
    rm -rf /var/lib/apt/lists/*


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