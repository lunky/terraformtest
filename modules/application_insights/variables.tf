variable "name" {
  description = "Name of the Application Insights resource"
  type        = string
}

variable "location" {
  description = "Azure region where the resource should be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resource"
  type        = map(string)
  default     = {}
}

variable "application_type" {
  description = "Type of the Application Insights"
  type        = string
  default     = "web"
}

variable "retention_in_days" {
  description = "Data retention in days"
  type        = number
  default     = 90
}
variable "workspace_id" {
}
