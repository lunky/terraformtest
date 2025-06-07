
# modules/postgres/variables.tf
variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "admin_password" { sensitive = true }
variable "admin_user" { }
variable "tags" { }
variable "database_name" { }
variable "private_dns_zone_id" {}
variable "subnet_id" {}
