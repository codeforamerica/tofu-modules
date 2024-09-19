terraform {
  required_version = ">= 1.6"

  required_providers {
    aptible = {
      version = "~> 0.9"
      source  = "aptible/aptible"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44"
    }
  }
}
