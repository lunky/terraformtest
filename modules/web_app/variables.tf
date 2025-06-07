# modules/web_app/variables.tf
variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "app_service_plan_id" {}
variable "tags" {}
variable "postgres_host" {}
variable "database_user" {}
variable "database_password" {}
variable "database_name" {}
variable "azure_storage_base_url" {}
variable "azure_storage_connection_string" {}
variable "azure_storage_container_name" {}
variable "applicationinsights_instrumentation_key" {
}
variable "applicationinsights_connection_string" {
}
