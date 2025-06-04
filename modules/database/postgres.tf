resource "azurerm_postgresql_flexible_server" "elf_postgres" {
  name                = "elf-dev-v2"
  resource_group_name = var.resource_group_name
  location            = "East US"
  sku_name            = "B_Standard_B1ms"
  storage_mb          = 32768  # 32GB converted to MB
  storage_tier        = "P4"
  auto_grow_enabled   = false
  
  version            = "16"
  
  administrator_login = "elfDevAdmin"
  administrator_password = var.postgres_admin_password
  # Note: need to set tfcloud variable postgres_admin_password
  
  zone               = "2"
  
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  
  high_availability {
    mode = "SameZone"
  }
  
  maintenance_window {
    day_of_week    = 0
    start_hour     = 0
    start_minute   = 0
  }

  authentication {
    active_directory_auth_enabled = false
    password_auth_enabled         = true
  }
}