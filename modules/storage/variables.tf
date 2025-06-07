variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "tags" {}
variable "container_name" {
  description = "Name of the blob container to create"
  type        = string
  default     = "images"
}
