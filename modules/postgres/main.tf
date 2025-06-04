resource "azurerm_postgresql_flexible_server" "this" {
  name                   = var.name
  location              = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = "elfDevAdmin"
  administrator_password = var.admin_password
  sku_name              = "B_Standard_B1ms"
  version               = "13"
  storage_mb            = 32768
  delegated_subnet_id   = null
  zone                  = "1"
  tags                  = var.tags

  high_availability {
    mode                      = "SameZone"
    standby_availability_zone = "1"  # Must match the primary zone
  }
}
