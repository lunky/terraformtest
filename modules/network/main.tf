# modules/network/main.tf
resource "azurerm_virtual_network" "this" {
  name                = var.name
  address_space = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
resource "azurerm_subnet" "private_endpoints" {
  name                 = "private-endpoints-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes = ["10.0.3.0/24"]  # Adjust CIDR as needed

  # These are the current recommended settings for private endpoints
  private_link_service_network_policies_enabled = false
  service_endpoints = ["Microsoft.Storage", "Microsoft.Sql"]
}
