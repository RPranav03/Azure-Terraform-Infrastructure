resource "azurerm_resource_group" "main" {
  name     = "rg-${var.environment}"
  location = var.location
}

module "vnet" {
  source = "./Modules/vnet"

  environment         = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
}

module "subnet" {
  source = "./Modules/subnet"

  environment         = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  
  depends_on = [module.vnet]
}

module "nsg" {
  source = "./modules/nsg"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  
  depends_on = [module.subnet]
}

module "firewall" {
  source = "./modules/firewall"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  firewall_subnet_id = module.subnet.firewall_subnet_id

  depends_on = [module.subnet]
}

module "private_endpoint" {
  source = "./modules/private-endpoint"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  private_subnet_id  = module.subnet.private_subnet_id

  depends_on = [module.subnet]
}

module "aks" {
  source = "./modules/aks"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id          = module.subnet.aks_subnet_id

  depends_on = [module.subnet]
}

module "appgw" {
  source = "./modules/appgw"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  appgw_subnet_id    = module.subnet.appgw_subnet_id

  depends_on = [module.subnet]
}

module "policy" {
  source = "./modules/policy"

  environment        = var.environment
  resource_group_name = azurerm_resource_group.main.name

  depends_on = [azurerm_resource_group.main]
}

module "appservice" {
  source = "./modules/appservice"

  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.main.name
  deploy_app_service = var.deploy_app_service  # Conditional

  depends_on = [module.subnet, module.nsg]
}

module "vnet_peering" {
  source = "./Modules/vnet-peering"

  resource_group_name = azurerm_resource_group.main.name
  hub_vnet_name      = module.vnet.hub_vnet_name
  hub_vnet_id        = module.vnet.hub_vnet_id
  spoke_vnet_name    = module.vnet.spoke_vnet_name
  spoke_vnet_id      = module.vnet.spoke_vnet_id

  depends_on = [module.vnet]
}