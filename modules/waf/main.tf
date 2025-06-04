resource "azurerm_cdn_frontdoor_firewall_policy" "this" {
  name                              = var.name
  resource_group_name               = var.resource_group_name
  mode                              = "Prevention"
  sku_name                          = "Standard_AzureFrontDoor"
  custom_block_response_status_code = 403
  custom_block_response_body        = base64encode("Access denied by WAF policy")
}
