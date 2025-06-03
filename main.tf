# Network resources
module "network" {
  source = "./modules/network"
}

# App Service resources
module "app_service" {
  source = "./modules/app_service"
  
  storage_connection_string = var.storage_connection_string
  db_connection_string     = var.db_connection_string
}

# Storage resources
module "storage" {
  source = "./modules/storage"
}