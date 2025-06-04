# Network resources
module "network" {
  source = "./modules/network"
  resource_group_name       = azurerm_resource_group.rg.name
  vnet_name                 = "RG-vnet"
}

# App Service resources
module "app_service" {
  source = "./modules/app_service"
  storage_connection_string = var.storage_connection_string
  db_connection_string      = var.db_connection_string
  storage_blob_endpoint     = module.storage.storage_blob_endpoint
  resource_group_name       = azurerm_resource_group.rg.name
}

# Storage resources
module "storage" {
  source = "./modules/storage"
  resource_group_name       = azurerm_resource_group.rg.name
}

module "database" {
  source = "./modules/database"
  resource_group_name       = azurerm_resource_group.rg.name
  postgres_admin_password   = var.postgres_admin_password
}
