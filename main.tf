# Root main.tf
module "network" {
  source              = "./modules/network"
  name                = var.vnet_name
  location            = var.location_east_us
  resource_group_name = var.resource_group
}

module "postgres" {
  source              = "./modules/postgres"
  name                = var.postgres_name
  location            = var.location_east_us
  admin_password      = var.postgres_admin_password
  resource_group_name = var.resource_group
  private_dns_zone    = var.private_dns_zone_name
}

module "app_service_plan_1" {
  source              = "./modules/app_service_plan"
  name                = var.app_service_plan_name_1
  location            = var.location_west_us2
  resource_group_name = var.resource_group
}

module "app_service_plan_2" {
  source              = "./modules/app_service_plan"
  name                = var.app_service_plan_name_2
  location            = var.location_west_us2
  resource_group_name = var.resource_group
}

module "web_app" {
  source              = "./modules/web_app"
  name                = var.web_app_name
  location            = var.location_west_us2
  resource_group_name = var.resource_group
  app_service_plan_id = module.app_service_plan_2.id
}

module "front_door" {
  source              = "./modules/front_door"
  name                = var.front_door_name
  resource_group_name = var.resource_group
  waf_policy_id       = module.waf.id
  backend_host        = var.front_door_backend_host
}

module "waf" {
  source              = "./modules/waf"
  name                = var.waf_name
  resource_group_name = var.resource_group
}

module "private_dns_zone" {
  source              = "./modules/private_dns_zone"
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group
}

module "virtual_network_link" {
  source              = "./modules/virtual_network_link"
  name                = var.vnet_link_name
  resource_group_name = var.resource_group
  dns_zone_name       = var.private_dns_zone_name
  virtual_network_id  = module.network.id
}

module "storage" {
  source              = "./modules/storage"
  name                = var.storage_account_name
  location            = var.location_west_us2
  resource_group_name = var.resource_group
}

module "action_group" {
  source              = "./modules/action_group"
  name                = var.action_group_name
  resource_group_name = var.resource_group
  short_name          = "act"
  email_receiver      = "alerts@example.com"
}

module "log_analytics" {
  source              = "./modules/log_analytics"
  name                = var.log_analytics_workspace_name
  location            = var.location_west_us2
  resource_group_name = var.default_resource_group
}
