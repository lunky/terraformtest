variable "storage_connection_string" {
  default = ""
}

variable "db_connection_string" {
  default = ""
}

variable "ARM_TENANT_ID" {
  description = "Azure Tenant ID"
  type        = string
}

variable "ARM_CLIENT_ID" {
  description = "Azure Client ID"
  type        = string
}

variable "ARM_CLIENT_SECRET" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "postgres_admin_password" {
  description = "The administrator password for PostgreSQL server"
  type        = string
  sensitive   = true
}
