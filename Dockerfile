FROM python:3.12-slim

WORKDIR /

COPY . .

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install dbt BigQuery adapter
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Ensure profiles dir exists
COPY .dbt/profiles.yml /.dbt/profiles.yml

# Set default environment variables
ENV DBT_PROFILES_DIR=/.dbt

# Run all dbt commands in order
ENTRYPOINT ["sh", "-c"]
CMD ["dbt deps --profiles-dir /.dbt && \
      dbt source freshness --profiles-dir /.dbt --target ${DBT_TARGET:-dev} && \
      dbt build --profiles-dir /.dbt --target ${DBT_TARGET:-dev}"]