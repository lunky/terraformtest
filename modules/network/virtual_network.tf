resource "azurerm_virtual_network" "tfer--RG-Initial-vnet" {
  address_space           = ["10.0.0.0/24"]
  flow_timeout_in_minutes = "4"
  location                = "eastus"
  name                    = "RG-Initial-vnet"
  resource_group_name     = "RG-Initial"
}
