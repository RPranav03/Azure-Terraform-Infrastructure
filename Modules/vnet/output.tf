output "hub_vnet_name" {
  description = "The name of the hub virtual network"
  value       = azurerm_virtual_network.hub.name
}

output "hub_vnet_id" {
  description = "The ID of the hub virtual network"
  value       = azurerm_virtual_network.hub.id
}

output "spoke_vnet_name" {
  description = "The name of the spoke virtual network"
  value       = azurerm_virtual_network.spoke.name
}

output "spoke_vnet_id" {
  description = "The ID of the spoke virtual network"
  value       = azurerm_virtual_network.spoke.id
}