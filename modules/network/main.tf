# modules/network/main.tf
resource "azurerm_virtual_network" "this" {
  name                = var.name
  address_space = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
resource "azurerm_subnet" "app_service" {
  name                 = "app-service-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes = ["10.0.4.0/24"]  # Use an appropriate address range that doesn't overlap with other subnets

  delegation {
    name = "app-service-delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "private_endpoints" {
  name                 = "private-endpoints-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes = ["10.0.3.0/24"]  # Adjust CIDR as needed


  # Add delegation for PostgreSQL Flexible Server
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
  service_endpoints = ["Microsoft.Storage", "Microsoft.Sql"]
}
