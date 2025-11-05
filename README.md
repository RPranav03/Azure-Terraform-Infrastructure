# Azure Terraform Infrastructure

A complete, modular Terraform setup for Azure cloud-native apps with:
- Hub & Spoke networking
- AKS cluster with Calico
- Application Gateway (Ingress)
- Azure Firewall + Private Endpoints
- Governance (Policies, Tags)
- Blue-Green via App Service Slots
- CI/CD with Azure DevOps

## Prerequisites
- Azure CLI logged in
- Terraform >=1.0
- Azure DevOps (optional for CI/CD)

## Usage
```bash
terraform init
terraform plan -var="environment=dev"
terraform apply



Deploy & Test

cd azure-terraform-infra
terraform init
terraform validate
terraform plan -var="environment=dev" -var="deploy_app_service=true"
terraform apply

Commit and push: git add . && git commit -m "Add full Azure IaC" && git push.