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

resource "null_resource" "create_db_user" {
  triggers = {
    server_id = azurerm_postgresql_flexible_server.this.id
  }

  provisioner "local-exec" {
    command = <<-EOT
      az postgres flexible-server execute \
        --name ${azurerm_postgresql_flexible_server.this.name} \
        --resource-group ${var.resource_group_name} \
        --admin-user ${azurerm_postgresql_flexible_server.this.administrator_login} \
        --admin-password '${var.admin_password}' \
        --database-name ${azurerm_postgresql_flexible_server_database.this.name} \
        --query-text "DO $$BEGIN IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '${var.database_user}') THEN CREATE USER ${var.database_user} WITH PASSWORD '${var.database_password}'; GRANT CONNECT ON DATABASE ${azurerm_postgresql_flexible_server_database.this.name} TO ${var.database_user}; GRANT USAGE ON SCHEMA public TO ${var.database_user}; END IF; END$$;"
    EOT
  }

  depends_on = [
    azurerm_postgresql_flexible_server_database.this
  ]
}
