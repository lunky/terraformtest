variable "storage_connection_string" {
  description = "Azure Storage Account connection string"
  type        = string
  sensitive   = true
}

variable "db_connection_string" {
  description = "Database connection string"
  type        = string
  sensitive   = true
}

variable "storage_blob_endpoint" {
  description = "Storage account blob endpoint URL"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "postgres_admin_password" {
  description = "The administrator password for PostgreSQL server"
  type        = string
  sensitive   = true
}