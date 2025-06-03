data "terraform_remote_state" "virtual_network" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/virtual_network/terraform.tfstate"
  }
}
