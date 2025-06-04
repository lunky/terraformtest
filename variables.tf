# variables.tf
variable "resource_group" {}
variable "default_resource_group" {}
variable "vnet_name" {}
variable "vnet_link_name" {}
variable "location_east_us" {}
variable "location_west_us2" {}
variable "postgres_name" {}
variable "postgres_admin_password" { sensitive = true }
variable "private_dns_zone_name" {}
variable "app_service_plan_name_1" {}
variable "app_service_plan_name_2" {}
variable "web_app_name" {}
variable "storage_account_name" {}
variable "front_door_name" {}
variable "waf_name" {}
variable "front_door_backend_host" {}
variable "action_group_name" {}
variable "log_analytics_workspace_name" {}

