terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.21.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.11.0"
    }

  }
}
