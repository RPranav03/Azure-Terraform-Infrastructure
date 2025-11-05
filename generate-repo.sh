#!/bin/bash
mkdir -p azure-terraform-infra/{modules/{network,nsg,firewall,private-endpoint,aks,appgw,policy,appservice},.}
cd azure-terraform-infra

# Create all files (use heredoc for content)
# Example for backend.tf
cat > backend.tf << 'EOF'
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstateprod123"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    use_msi              = true
  }
}
EOF

# Repeat for all files... (abbreviated; expand with all contents above)

# For modules, loop or manually
for mod in network nsg firewall private-endpoint aks appgw policy appservice; do
  mkdir -p modules/$mod
  # Add main.tf, variables.tf, outputs.tf contents here
done

echo "Repo generated! git init && git add . && git commit -m 'Initial commit' && git remote add origin <your-repo-url> && git push -u origin main"