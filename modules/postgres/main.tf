resource "azurerm_postgresql_flexible_server" "this" {
  name                   = var.name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = var.admin_user
  administrator_password = var.admin_password
  sku_name               = "B_Standard_B1ms"
  version                = "13"
  storage_mb             = 32768
  delegated_subnet_id    = null
  # zone =  "2"
  # high_availability {
  #   mode = "ZoneRedundant"
  # }
  tags                   = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

# Create a temporary firewall rule to allow Azure to connect
resource "azurerm_postgresql_flexible_server_firewall_rule" "azure" {
  name             = "allow-azure-services"
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"  # This special range allows Azure services
}

# Create user and grant permissions using psql
resource "null_resource" "setup_db" {
  triggers = {
    server_id = azurerm_postgresql_flexible_server.this.id
    database  = azurerm_postgresql_flexible_server_database.this.name
  }

  provisioner "local-exec" {
    command = <<-EOT
      PGPASSWORD='${var.admin_password}' psql "host=${azurerm_postgresql_flexible_server.this.fqdn} port=5432 dbname=${azurerm_postgresql_flexible_server_database.this.name} user=${azurerm_postgresql_flexible_server.this.administrator_login} sslmode=require" -c "
        DO $$
        BEGIN
          IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '${var.database_user}') THEN
            CREATE USER ${var.database_user} WITH PASSWORD '${var.database_password}';
          END IF;
          GRANT CONNECT ON DATABASE ${var.database_name} TO ${var.database_user};
          GRANT USAGE ON SCHEMA public TO ${var.database_user};
        END
        $$;"
    EOT
  }

  depends_on = [
    azurerm_postgresql_flexible_server.this,
    azurerm_postgresql_flexible_server_database.this,
    azurerm_postgresql_flexible_server_firewall_rule.azure
  ]
}
