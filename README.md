# Simple Counter App - Python, Redis, Kubernetes, Terraform

## Overview
This project demonstrates a simple Python web application that acts as a counter, storing the visit count in a Redis instance. The app is deployed on **Azure Kubernetes Service (AKS)**, with the option to store Docker images in **Azure Container Registry (ACR)**. The infrastructure is managed and deployed using **Terraform**, allowing for flexibility and easy scaling, including the possibility to create multiple node pools in AKS.

## Features
- **Python (Flask)**: Web app that tracks visit count.
- **Redis**: Used for stateful data storage (visit count).
- **Azure Kubernetes Service (AKS)**: Deployed on Azure's managed Kubernetes service.
- **Azure Container Registry (ACR)**: Option to store Docker images (commented section in Terraform code).
- **Terraform**: Infrastructure management, including the ability to create multiple node pools in AKS.

## Prerequisites
Before you begin, make sure you have the following installed:
- [Docker](https://www.docker.com/get-started)
- [Kubernetes CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Terraform](https://www.terraform.io/downloads.html)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Python](https://www.python.org/downloads/)

## Setup

### 1. Clone the Repository
Clone this repository to your local machine:
```bash
git clone https://github.com/am11001/counterwebapp-python-redis-terraform-kubernetes.git
cd counterwebapp-python-redis-terraform-kubernetes
```


## Deploy Infrastructure with Terraform

### Azure Resources Setup

### Authentication

Ensure you're authenticated with your Azure account:

```bash
az login
```

### Terraform Initialization

Initialize Terraform:

```bash
terraform init
```

### Azure Container Registry (Optional)

If you want to store images in Azure Container Registry (ACR), uncomment the relevant section in `terraform/main.tf` (see the commented-out section for ACR setup).

### Multiple Node Pools (Optional)

To create multiple node pools, uncomment the relevant section in the Terraform configuration file.

### Deployment

To deploy the infrastructure:

```bash
terraform apply
```

This command will create the necessary Azure resources (e.g., AKS, VMs) and deploy the Python app.

## Additional Notes

- Ensure you have the latest version of Terraform installed
- Verify your Azure credentials before deployment
- Review the Terraform configuration files carefully before applying changes


## Docker and Kubernetes Deployment Guide

### Docker Build Process
When building a Docker image for DockerHub, use a clear naming convention:
```bash
docker build -t username/app-name:version .
docker push username/app-name:version
```
- Replace `username` with your DockerHub username
- Use meaningful `app-name` and `version` tags
- The `.` specifies the current directory as build context

### Kubernetes Deployment
After building and pushing your image, deploy to Kubernetes:
```bash
# Set kubeconfig path
export KUBECONFIG=/files/kubeconfig

# Apply all manifests in the directory
kubectl apply -f ./manifests
```
- Ensure kubeconfig is correctly configured
- `./manifests` directory should contain your Kubernetes resource definitions
- Verify deployments after applying manifests

Key steps: build image → push to registry → set kubeconfig → deploy manifests

### Notes
* The Terraform configuration for creating multiple node pools is included but commented out. To enable it, uncomment the relevant section in the `terraform/main.tf` file.
* The option to use **Azure Container Registry (ACR)** for storing Docker images is also available in the Terraform configuration. Uncomment the code to enable it.