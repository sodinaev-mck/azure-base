terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = ">= 4.0, <5.0"
    random  = "3.6.3"
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.62.0"
    }
  }

  cloud {
    organization = "slingers"
    workspaces {
      name = "azure-base"
    }
  }

}

provider "azurerm" {
  use_cli = false
  features {}
}

provider "github" {}

provider "tfe" {

}