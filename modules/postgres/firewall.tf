# modules/postgres/firewall.tf
# Allow specific IP address
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_quinn" {
  name             = "AllowQuinn"
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = "104.246.135.160"
  end_ip_address   = "104.246.135.160"
}
