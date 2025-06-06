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
