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