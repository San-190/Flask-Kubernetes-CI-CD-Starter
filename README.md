# Flask Kubernetes Azure Pipelines Starter

This project is a minimal starter template to deploy Python (Flask) web applications using Docker, Azure Pipelines CI/CD, and Kubernetes. Built images are intended to be stored in Azure Container Registry (ACR).

## Features

- Simple Flask application.
- Dockerfile for containerizing the app.
- Azure Pipelines configuration to build and push Docker images to ACR.
- Kubernetes manifest for deployment (with placeholders for image and secrets).

## Project structure

```
.
├── azure-pipelines.yml      # CI/CD pipeline (contains placeholders to configure)
├── Dockerfile               # Dockerfile for the Flask app
├── k8s/
│   └── deployment.yml       # Kubernetes Deployment manifest (uses placeholders)
├── src/
│   ├── app.py               # Flask application
│   └── requirements.txt     # Python dependencies
├── static/                  # Static files (optional)
└── templates/               # HTML templates (optional)
```

## Important notes about placeholders

- The pipeline and k8s manifests include placeholders and must be configured before use.
  - azure-pipelines.yml contains variables such as `imageName`, `registry`, and the service-connection name for pushing to ACR. Also update Azure subscription, resource group and cluster names for the Kubernetes task.
  - k8s/deployment.yml includes placeholders like `<ACR_REGISTRY>/<IMAGE_NAME>:<IMAGE_TAG>` for the image and `<ACR_SECRET_NAME>` for the imagePullSecret.
- Do NOT hardcode secrets in files. Use pipeline variables, Variable Groups, or Azure Key Vault for credentials.
- If your repository uses `main` instead of `master`, update the pipeline trigger accordingly.

## Deployment flow (CI/CD)

1. Push to the configured branch (pipeline trigger).
2. Azure Pipelines installs dependencies and builds the Docker image.
3. The image is pushed to the specified ACR repository.
4. The pipeline updates the k8s manifest image reference and applies it to the target cluster (kubectl apply), performing the rollout.

## Local development and testing

- Install dependencies:
  - python -m pip install -r src/requirements.txt
- Run locally:
  - python src/app.py  (the app listens on 0.0.0.0:5000)
- Build and run with Docker:
  - docker build -t my-app -f Dockerfile .
  - docker run -p 5000:5000 my-app

## Recommendations

- The Docker image runs the Flask development server. For production, replace the CMD with a production WSGI server (e.g., gunicorn).
- Add a `.dockerignore` to avoid copying unnecessary files into the image.
- Pin dependency versions in `src/requirements.txt`.
- Add liveness/readiness probes and resource requests/limits in the k8s manifest for production workloads.

## Requirements

- Azure DevOps with Azure Pipelines configured.
- Azure Container Registry (ACR) or another container registry.
- Kubernetes cluster (AKS or compatible).
- Docker and kubectl for local testing or manual deployments.

---

Developed for educational purposes.
