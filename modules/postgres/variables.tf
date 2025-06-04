
# modules/postgres/variables.tf
variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "admin_password" { sensitive = true }
variable "private_dns_zone" {}

