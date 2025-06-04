# Root main.tf
module "network" {
  source              = "./modules/network"
  name                = local.vnet_name
  location            = var.location
  resource_group_name = local.resource_group
}

module "postgres" {
  source              = "./modules/postgres"
  name                = local.postgres_name
  location            = var.location
  admin_password      = var.postgres_admin_password
  resource_group_name = local.resource_group
}

module "app_service_plan" {
  source              = "./modules/app_service_plan"
  name                = local.app_service_plan_name
  location            = var.location
  resource_group_name = local.resource_group
}

module "web_app" {
  source              = "./modules/web_app"
  name                = local.web_app_name
  location            = var.location
  resource_group_name = local.resource_group
  app_service_plan_id = module.app_service_plan.id
}

module "front_door" {
  source              = "./modules/front_door"
  name                = local.front_door_name
  resource_group_name = local.resource_group
  waf_policy_id       = module.waf.id
}

module "waf" {
  source              = "./modules/waf"
  name                = local.waf_name
  resource_group_name = local.resource_group
}

module "private_dns_zone" {
  source              = "./modules/private_dns_zone"
  name                = local.private_dns_zone_name
  resource_group_name = local.resource_group
}

module "virtual_network_link" {
  source              = "./modules/virtual_network_link"
  name                = local.vnet_link_name
  resource_group_name = local.resource_group
  dns_zone_name       = local.private_dns_zone_name
  virtual_network_id  = module.network.id
}

module "storage" {
  source              = "./modules/storage"
  name                = local.storage_account_name
  location            = var.location
  resource_group_name = local.resource_group
}

module "action_group" {
  source              = "./modules/action_group"
  name                = local.action_group_name
  resource_group_name = local.resource_group
  short_name          = "act"
  email_receiver      = "alerts@example.com"
}

module "log_analytics" {
  source              = "./modules/log_analytics"
  name                = local.log_analytics_workspace_name
  location            = var.location
  resource_group_name = local.resource_group
}
