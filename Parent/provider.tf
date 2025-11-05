terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }

    backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstateprod123"  # Make globally unique!
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    use_msi              = true  # For Azure DevOps Managed Identity
  }
}

provider "azurerm" {
  features {}
  subscription_id = ""
}