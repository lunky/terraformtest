# modules/front_door/outputs.tf
output "endpoint" {
  value = azurerm_cdn_frontdoor_endpoint.this.host_name
}

output "id" {
  value = azurerm_cdn_frontdoor_firewall_policy.this.id
}

output "sku_name" {
  value = azurerm_cdn_frontdoor_firewall_policy.this.sku_name
}

output "origin_group_id" {
  value = azurerm_cdn_frontdoor_origin_group.this.id
}
