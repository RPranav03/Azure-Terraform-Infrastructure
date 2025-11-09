resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub-${var.environment}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}


resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-spoke-${var.environment}"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

