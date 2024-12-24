terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.9.0"
    }
    kubectl = {
      source = "alekc/kubectl"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {
  }
}
