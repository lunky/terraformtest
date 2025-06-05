
# modules/postgres/variables.tf
variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "admin_password" { sensitive = true }
variable "admin_user" { }
variable "tags" { }

variable "database_name" { }
variable "database_user" { }
variable "database_password" { }
