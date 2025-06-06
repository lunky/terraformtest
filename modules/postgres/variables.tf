
# modules/postgres/variables.tf
variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "admin_password" { sensitive = true }
variable "admin_user" { }
variable "tags" { }
variable "database_name" { }
# --
variable "username" {
  type        = string
  description = "Username to create"
}

variable "password" {
  type        = string
  description = "Password for the user"
  sensitive   = true
}

variable "database" {
  type        = string
  description = "Target database for user grants"
}
