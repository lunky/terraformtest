resource "azurerm_service_plan" "elf_service_plan" {
  name                = "elf-app-service-plan"
  resource_group_name = var.resource_group_name
  location            = "westus2"
  os_type            = "Linux"
  sku_name           = "S1"
}