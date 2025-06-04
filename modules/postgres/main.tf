resource "azurerm_postgresql_flexible_server" "this" {
  name                   = var.name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = "elfDevAdmin"
  administrator_password = var.admin_password
  sku_name              = "B_Standard_B1ms"
  version               = "13"
  storage_mb            = 32768
  delegated_subnet_id   = null
  zone                  = "1"  # Explicitly set the zone
  tags                  = var.tags

  high_availability {
    mode                      = "Disabled"
  }
}
