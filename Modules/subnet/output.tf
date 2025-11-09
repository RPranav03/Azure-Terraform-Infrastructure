output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "appgw_subnet_id" {
  value = azurerm_subnet.appgw.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private.id
}

output "firewall_subnet_id" {
  value = azurerm_subnet.firewall.id
}