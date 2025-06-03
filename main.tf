# Network resources
module "network" {
  source = "./modules/network"
}

# App Service resources
module "app_service" {
  source = "./modules/app_service"
  
  storage_connection_string = var.storage_connection_string
  db_connection_string     = var.db_connection_string
  storage_blob_endpoint    = module.storage.storage_blob_endpoint
}

# Storage resources
module "storage" {
  source = "./modules/storage"
}