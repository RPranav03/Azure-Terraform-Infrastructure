resource "azurerm_app_service_plan" "main" {
  name                = "asp-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "App"
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "random_string" "app" {
  count   = var.deploy_app_service ? 1 : 0
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_app_service" "main" {
  count               = var.deploy_app_service ? 1 : 0
  name                = "app-${var.environment}-${random_string.app[0].result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    dotnet_framework_version = "v6.0"
  }
}

resource "azurerm_app_service_slot" "staging" {
  count               = var.deploy_app_service ? 1 : 0
  name                = "staging"
  app_service_name    = azurerm_app_service.main[0].name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    dotnet_framework_version = "v6.0"
  }
}