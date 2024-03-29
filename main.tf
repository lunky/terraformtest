variable "username" {
}

provider "aws" { 
  region         = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "midworld-terraform-up-and-running-state-2"  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "midworld-terraform-up-and-running-state-2"
    encrypt        = true
  }
}
