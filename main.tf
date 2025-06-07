# Root main.tf
module "resource_group" {
  source   = "./modules/resource_group"
  name     = local.resource_group
  location = var.location
  tags     = local.default_tags
}

module "network" {
  source              = "./modules/network"
  name                = local.vnet_name
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = local.default_tags
}

module "postgres" {
  source              = "./modules/postgres"
  name                = local.postgres_name
  location            = var.location
  admin_password      = var.postgres_admin_password
  admin_user          = var.postgres_admin_user
  resource_group_name = module.resource_group.name
  tags                = local.default_tags
  database_name       = local.database_name  # confirm this variables
}


module "app_service_plan" {
  source                    = "./modules/app_service_plan"
  name                      = local.app_service_plan_name
  location                  = var.location
  resource_group_name       = module.resource_group.name
  app_service_plan_sku_name = "S1" # Standard tier for production
  # app_service_plan_sku_name = "F1" # Free tier for development/testing
  tags                      = local.default_tags
}

module "web_app" {
  source              = "./modules/web_app"
  name                = local.web_app_name
  location            = var.location
  resource_group_name = module.resource_group.name
  app_service_plan_id = module.app_service_plan.id
  tags                = local.default_tags
  postgres_host       = module.postgres.host
  database_user       = local.database_user
  database_password   = local.database_user_password
  database_name       = local.database_name
  azure_storage_base_url = module.storage.blob_storage_url
  azure_storage_connection_string = module.storage.blob_storage_connection_string
  azure_storage_container_name =  "images"
  applicationinsights_connection_string = module.application_insights.connection_string
    applicationinsights_instrumentation_key = module.application_insights.instrumentation_key

}

module "front_door" {
  source              = "./modules/front_door"
  name                = local.front_door_name
  resource_group_name = module.resource_group.name
  waf_policy_id       = module.waf.id
  backend_host        = module.web_app.url
  tags                = local.default_tags
}

module "waf" {
  source              = "./modules/waf"
  name                = local.waf_name
  resource_group_name = module.resource_group.name
  sku_name            = module.front_door.sku_name
  tags                = local.default_tags
}

module "private_dns_zone" {
  source              = "./modules/private_dns_zone"
  name                = local.private_dns_zone_name
  resource_group_name = module.resource_group.name
  tags                = local.default_tags
}

module "virtual_network_link" {
  source              = "./modules/virtual_network_link"
  name                = local.vnet_link_name
  resource_group_name = module.resource_group.name
  dns_zone_name       = module.private_dns_zone.name
  virtual_network_id  = module.network.id
  tags                = local.default_tags
}

module "storage" {
  source              = "./modules/storage"
  name                = local.storage_account_name
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = local.default_tags
}

module "action_group" {
  source              = "./modules/action_group"
  name                = local.action_group_name
  resource_group_name = module.resource_group.name
  short_name          = "act"
  email_receiver      = "alerts@example.com"
  tags                = local.default_tags
}

module "log_analytics" {
  source              = "./modules/log_analytics"
  name                = local.log_analytics_workspace_name
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = local.default_tags
}

module "application_insights" {
  source              = "./modules/application_insights"
  name                = "${var.web_app_name}-appinsights"
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = local.default_tags
}
