terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.117.1"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.21.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.11.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4.0"
    }

  }
  cloud {
    organization = "np-gw-elf"
    workspaces {
      name = "terraformtest"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "postgresql" {
  host            = module.postgres.host
  port            = 5432
  database        = local.database_name
  username        = "${module.postgres.administrator_login}@${local.postgres_name}.postgres.database.azure.com"  # Add server name to username
  password        = var.postgres_admin_password
  sslmode         = "require"
  connect_timeout = 30
}
