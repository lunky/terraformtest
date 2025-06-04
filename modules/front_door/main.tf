# modules/front_door/main.tf
resource "azurerm_cdn_frontdoor_profile" "this" {
  name                = "${var.name}-profile"
  resource_group_name = var.resource_group_name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                = "${var.name}-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
}
# --

# # Additional Front Door configuration as needed
# resource "azurerm_cdn_frontdoor_origin_group" "this" {
#   name                     = "${var.name}-origin-group"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
#   session_affinity_enabled = false
#
#   load_balancing {
#     sample_size                 = 4
#     successful_samples_required = 3
#   }
# }
#
# resource "azurerm_cdn_frontdoor_origin" "this" {
#   name                          = "${var.name}-origin"
#   cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id
#   enabled                       = true
#
#   host_name          = var.backend_host
#   http_port          = 80
#   https_port         = 443
#   priority           = 1
#   weight             = 1000
# }

resource "azurerm_cdn_frontdoor_firewall_policy" "this" {
  name                              = var.name
  resource_group_name              = var.resource_group_name
  mode                             = "Prevention"
  custom_block_response_status_code = 403
  custom_block_response_body        = base64encode("Access denied by WAF policy")
  sku_name            = "Standard_AzureFrontDoor"
}
