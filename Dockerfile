# Dockerfile
FROM python:3.12-slim

WORKDIR /
COPY . .

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install dbt BigQuery adapter
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Ensure profiles dir exists
COPY .dbt/profiles.yml /.dbt/profiles.yml

# Run all dbt commands in order
ENTRYPOINT ["sh", "-c"]
CMD ["dbt deps --profiles-dir $DBT_PROFILES_DIR && \
      dbt source freshness --profiles-dir $DBT_PROFILES_DIR && \
      dbt build --profiles-dir $DBT_PROFILES_DIR"]
