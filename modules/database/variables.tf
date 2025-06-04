variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}
variable "postgres_admin_password" {
  type= string
  sensitive = true
}
