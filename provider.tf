terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.117.1"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.25.0"  # Using your current installed version

    }

  }
  cloud {
    organization = "np-gw-elf"
    workspaces {
      name = "terraformtest"
    }
  }
}

provider "postgresql" {
  alias = "db"
  host            = module.postgres.host
  port            = 5432
  database        = var.database_name
  username        = module.postgres.administrator_login
  password        = var.postgres_admin_password
  sslmode         = "require"
  connect_timeout = 15
}

provider "azurerm" {
  features {
  }
  skip_provider_registration = true
}
