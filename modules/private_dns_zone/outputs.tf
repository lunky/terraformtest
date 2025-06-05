# modules/private_dns_zone/outputs.tf
output "id" {
  value = azurerm_private_dns_zone.this.id
}

output "name" {
  value = azurerm_private_dns_zone.this.name
}
