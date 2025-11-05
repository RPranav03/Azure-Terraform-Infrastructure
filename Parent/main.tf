terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  required_version = ">=1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.environment}"
  location = var.location
}

module "network" {
  source = "./modules/network"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
}

module "nsg" {
  source = "./modules/nsg"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
}

module "firewall" {
  source = "./modules/firewall"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  firewall_subnet_id = module.network.firewall_subnet_id
}

module "private_endpoint" {
  source = "./modules/private-endpoint"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  private_subnet_id  = module.network.private_subnet_id
}

module "aks" {
  source = "./modules/aks"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id          = module.network.aks_subnet_id
}

module "appgw" {
  source = "./modules/appgw"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  appgw_subnet_id    = module.network.appgw_subnet_id
}

module "policy" {
  source = "./modules/policy"

  environment        = var.environment
  resource_group_name = azurerm_resource_group.main.name
}

module "appservice" {
  source = "./modules/appservice"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  deploy_app_service = var.deploy_app_service  # Conditional
}




# #### Modules (Each in `modules/<name>/`)

# **modules/network/**

# *main.tf*
# ```hcl
# resource "azurerm_virtual_network" "hub" {
#   name                = "vnet-hub-${var.environment}"
#   address_space       = ["10.0.0.0/16"]
#   location            = var.location
#   resource_group_name = var.resource_group_name
# }

# resource "azurerm_subnet" "firewall" {
#   name                 = "AzureFirewallSubnet"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.hub.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

# resource "azurerm_virtual_network" "spoke" {
#   name                = "vnet-spoke-${var.environment}"
#   address_space       = ["10.1.0.0/16"]
#   location            = var.location
#   resource_group_name = var.resource_group_name
# }

# # Subnets for workloads
# resource "azurerm_subnet" "aks" {
#   name                 = "subnet-aks"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.spoke.name
#   address_prefixes     = ["10.1.1.0/24"]
# }

# resource "azurerm_subnet" "appgw" {
#   name                 = "subnet-appgw"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.spoke.name
#   address_prefixes     = ["10.1.2.0/24"]
# }

# resource "azurerm_subnet" "private" {
#   name                 = "subnet-private"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.spoke.name
#   address_prefixes     = ["10.1.3.0/24"]
#   private_endpoint_network_policies = "Enabled"
# }

# # Peering
# resource "azurerm_virtual_network_peering" "hub_to_spoke" {
#   name                      = "peer-hub-to-spoke"
#   resource_group_name       = var.resource_group_name
#   virtual_network_name      = azurerm_virtual_network.hub.name
#   remote_virtual_network_id = azurerm_virtual_network.spoke.id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic   = true
# }

# resource "azurerm_virtual_network_peering" "spoke_to_hub" {
#   name                      = "peer-spoke-to-hub"
#   resource_group_name       = var.resource_group_name
#   virtual_network_name      = azurerm_virtual_network.spoke.name
#   remote_virtual_network_id = azurerm_virtual_network.hub.id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic   = true
# }

# output "firewall_subnet_id" {
#   value = azurerm_subnet.firewall.id
# }

# output "aks_subnet_id" {
#   value = azurerm_subnet.aks.id
# }

# output "appgw_subnet_id" {
#   value = azurerm_subnet.appgw.id
# }

# output "private_subnet_id" {
#   value = azurerm_subnet.private.id
# }