
# modules/network/outputs.tf
output "id" {
  value = azurerm_virtual_network.this.id
}
output "name" {
  value = azurerm_virtual_network.this.name
}
output "private_endpoints_subnet_id" {
  value = azurerm_subnet.private_endpoints.id
}
output "app_service_subnet_id" {
  value = azurerm_subnet.app_service.id
}
