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

data "http" "tfcloud_ip" {
  url = "https://api.ipify.org"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "tfcloud" {
  name             = "allow-tfcloud-temporary"
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = data.http.tfcloud_ip.response_body
  end_ip_address   = data.http.tfcloud_ip.response_body

  # This will destroy the rule after the database user is created
  lifecycle {
    create_before_destroy = true
  }
}
# This null_resource will trigger the destruction of the firewall rule
resource "null_resource" "firewall_cleanup" {
  triggers = {
    rotation_time = time_rotating.firewall_rotation.rotation_rfc3339
    rotation_time = time_rotating.firewall_rotation.rotation_rfc3339

  }

  provisioner "local-exec" {
    when    = destroy
    command = "sleep 30"  # Give time for PostgreSQL operations to complete
  }

  depends_on = [
    postgresql_role.user,
    postgresql_grant.connect,
    azurerm_postgresql_flexible_server_firewall_rule.tfcloud
  ]
}

resource "time_rotating" "firewall_rotation" {
  rotation_minutes = 5
}


# Add a dependency to ensure the firewall rule is created before attempting PostgreSQL provider operations
resource "null_resource" "wait_for_firewall" {
  depends_on = [ azurerm_postgresql_flexible_server_firewall_rule.tfcloud ]

  triggers = {
    firewall_id = azurerm_postgresql_flexible_server_firewall_rule.tfcloud.id
  }
}

# Add a time delay after firewall rule creation
resource "time_sleep" "wait_for_firewall" {
  depends_on = [azurerm_postgresql_flexible_server_firewall_rule.tfcloud]
  create_duration = "30s"
}

resource "postgresql_role" "user" {
  depends_on = [time_sleep.wait_for_firewall]
  name     = var.username
  login    = true
  password = var.password
}

resource "postgresql_grant" "connect" {

  database    = var.database
  role        = postgresql_role.user.name
  object_type = "database"
  privileges  = ["CONNECT"]
}
