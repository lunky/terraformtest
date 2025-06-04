# modules/waf/outputs.tf
output "id" {
  value = azurerm_cdn_frontdoor_firewall_policy.this.id
}
 
