# modules/postgres/outputs.tf
output "id" {
  value = azurerm_postgresql_flexible_server.this.id
}