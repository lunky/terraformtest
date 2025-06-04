resource "azurerm_service_plan" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type            = "Linux"  # or "Windows" depending on your needs
  sku_name           = "B1"     # Basic tier, adjust according to your needs
}
