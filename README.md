# GCP Data Engineering Infrastructure Template

Template for bootstrapping a DBT project on Google Cloud Platform. This template sets up DBT to be ready to run on Cloud Run Jobs and implements CI/CD pipelines for both development and production environments.
This repository is a part of global project which contains:

| Project       | GitHub repository                                     |
|---------------|-------------------------------------------------------|
| **Terraform** | https://github.com/serhiipuzyrov/data-platform-infra  |
| **DBT**       | https://github.com/serhiipuzyrov/data-platform-dbt    |

## 📋 Overview

This repository provides a ready-to-use infrastructure setup that includes:
- Connection to BigQuery
- Multi-environment configuration (dev/prod)
- CI/CD pipeline automation
- Automatic dbt documentation generation and upload to Cloud Storage → https://storage.googleapis.com/dbt-docs-${PROJECT_ID}/index.html

## 🔧 Configuration

### Global Settings

| Parameter          | Value                 |
|--------------------|-----------------------|
| **DBT Repository** | `data-platform-dbt`   |
| **Region**         | `europe-central2`     |

### GCP Development Environment

| Parameter       | Value                       |
|-----------------|-----------------------------|
| **Project ID**  | `data-platform-dev-477621`  |


### GCP Production Environment

| Parameter       | Value                        |
|-----------------|------------------------------|
| **Project ID**  | `data-platform-prod-477621`  |

## 🚀 Getting Started

1. Clone this repository
2. Update the configuration values in the tables above to match your GCP projects
3. Authenticate with GCP: gcloud auth application-default login
4. Install Python packages: pip install -r requirements.txt
5. Test dbt locally: dbt run
6. Push project to Your GitHub

## 📝 Notes

Make sure to replace all configuration values with your own project details before deployment.