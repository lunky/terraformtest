terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.117.1"
    }
  }
  cloud {
    organization = "np-gw-elf"
    workspaces {
      name = "terraformtest"
    }
  }
}
