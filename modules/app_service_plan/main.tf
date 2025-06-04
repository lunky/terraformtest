resource "azurerm_service_plan" "this" {
  name                = var.name
  location            = "West US"
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "S1"
  tags                = var.tags
}
