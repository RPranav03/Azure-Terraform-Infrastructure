resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks${var.environment}"

  default_node_pool {
    name                = "agentpool"
    node_count          = 3
    vm_size             = "Standard_D2s_v3"
    vnet_subnet_id      = var.subnet_id
    min_count           = 3
    max_count           = 10
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
    service_cidr   = "10.2.0.0/16"
    dns_service_ip = "10.2.0.10"
  }

  tags = {
    environment = var.environment
    cost-center = "eng"
  }
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}