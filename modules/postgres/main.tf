resource "azurerm_postgresql_flexible_server" "this" {
  name                   = var.name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = var.admin_user
  administrator_password = var.admin_password
  sku_name               = "B_Standard_B1ms"
  version                = "13"
  storage_mb             = 32768

  # Enable private access
  private_dns_zone_id = var.private_dns_zone_id
  delegated_subnet_id = var.subnet_id

  # Important: Remove any public access
  public_network_access_enabled = false
  # Enable private access

  tags                   = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
