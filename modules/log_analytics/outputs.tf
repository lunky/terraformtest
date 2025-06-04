# modules/log_analytics/outputs.tf
output "id" {
  value = azurerm_log_analytics_workspace.this.id
}
