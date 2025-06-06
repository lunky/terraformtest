# modules/postgres/outputs.tf
output "id" {
  value = azurerm_postgresql_flexible_server.this.id
}

output "host" {
  value = azurerm_postgresql_flexible_server.this.fqdn
}

output "administrator_login" {
  value = azurerm_postgresql_flexible_server.this.administrator_login
}

# output "detected_ip" {
#   value = data.http.tfcloud_ip.response_body
# }
# output "firewall_rule" {
#   value = azurerm_postgresql_flexible_server_firewall_rule.tfcloud.id
# }
