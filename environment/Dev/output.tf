output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "aks_cluster_name" {
  value = module.aks.aks_cluster_name
}

output "app_gateway_ip" {
  value = module.appgw.app_gateway_ip
}