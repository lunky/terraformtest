# modules/app_service_plan/variables.tf
variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "tags" { }
variable "app_service_plan_sku_name" {
  default = "F1"
}
