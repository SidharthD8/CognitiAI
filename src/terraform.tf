terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.74"
    }
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}
