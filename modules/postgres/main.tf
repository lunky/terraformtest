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

  tags                   = var.tags
}

# Add private DNS zone A record
resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "${var.name}-pdz-vnet-link"
  private_dns_zone_name = var.private_dns_zone_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
