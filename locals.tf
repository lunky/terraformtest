locals {
  resource_group               = "${var.resource_group}-${terraform.workspace}"
  vnet_name                    = "${var.vnet_name}-${terraform.workspace}"
  vnet_link_name               = "${var.vnet_link_name}-${terraform.workspace}"
  postgres_name                = "${var.postgres_name}-${terraform.workspace}"
  private_dns_zone_name        = "${var.private_dns_zone_name}-${terraform.workspace}"
  app_service_plan_name        = "${var.app_service_plan_name}-${terraform.workspace}"
  web_app_name                 = "${var.web_app_name}-${terraform.workspace}"
  storage_account_name         = "${var.storage_account_name}${terraform.workspace}"
  front_door_name              = "${var.front_door_name}${terraform.workspace}"
  waf_name                     = "${var.waf_name}${terraform.workspace}"
  action_group_name            = "${var.action_group_name}-${terraform.workspace}"
  log_analytics_workspace_name = "${var.log_analytics_workspace_name}-${terraform.workspace}"
  database_name                = var.database_name
  default_tags = {
    environment = terraform.workspace
    created_by  = "Terraform"
  }
}
