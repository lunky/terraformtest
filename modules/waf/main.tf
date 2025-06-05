resource "azurerm_cdn_frontdoor_firewall_policy" "this" {
  name                              = var.name
  resource_group_name               = var.resource_group_name
  sku_name                          = var.sku_name
  enabled                           = true
  mode                             = "Prevention"
  custom_block_response_status_code = 403
  custom_block_response_body        = base64encode("Access denied by WAF policy")
  tags                             = var.tags

  custom_rule {
    name                           = "AllowQuinn"
    enabled                        = true
    priority                       = 1
    rate_limit_duration_in_minutes = 1
    rate_limit_threshold          = 1000
    type                          = "MatchRule"
    action                        = "Allow"

    match_condition {
      match_variable     = "RemoteAddr"
      operator           = "IPMatch"
      negation_condition = false
      match_values       = ["104.246.135.160"]
    }
  }

  custom_rule {
    name                           = "BlockAll"
    enabled                        = true
    priority                       = 2
    rate_limit_duration_in_minutes = 1
    rate_limit_threshold          = 1000
    type                          = "MatchRule"
    action                        = "Block"

    match_condition {
      match_variable     = "RemoteAddr"
      operator           = "IPMatch"
      negation_condition = false
      match_values       = ["0.0.0.0/0", "::/0"]
    }
  }
}
