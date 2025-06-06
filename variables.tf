# variables.tf
# these must be defined in tfcloud
variable "postgres_name" { }
variable "postgres_admin_password" { sensitive = true }
variable "private_dns_zone_name" {
}
# default values for variables used in the root module
variable "resource_group" {
  default = "resource-group"
}
variable "vnet_name" {
  default = "vnet"
}
variable "vnet_link_name" {
    default = "vnet-link"
}
variable "location" {
  default = "West US"
}
variable "app_service_plan_name" {
    default = "elf-app-service-plan"
}
variable "web_app_name" {
    default = "elf-web-app"
}
variable "storage_account_name" {
    default = "elfstorage"
}
variable "front_door_name" {
    default = "elffrontdoor"
}
variable "waf_name" {
    default = "elfwafpolicy"
}
variable "action_group_name" {
    default = "elf-action-group"
}
variable "log_analytics_workspace_name" {
    default = "elf-log-analytics-workspace"
}
variable "database_name" {
    default = "elf"
}
variable "database_user" {
  default = "elfDevAdmin"
}
variable "database_password" {
}

# these are defined in tfcloud and they are required, they're added here to keep
# tfcloud from complaining that there is a "Value for undeclared variable"
variable "ARM_CLIENT_ID" {
  type      = string
  sensitive = true
}

variable "ARM_CLIENT_SECRET" {
  type      = string
  sensitive = true
}

variable "ARM_TENANT_ID" {
  type = string
  sensitive = true
}
