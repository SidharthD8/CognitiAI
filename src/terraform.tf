terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.116.0, < 5.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.13, < 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    modtm = {
      source  = "azure/modtm"
      version = "~> 0.3"
    }
  }
}
provider "azurerm" {
  features {}
  storage_use_azuread = true
}
provider "azurerm" {
  tenant_id       = "6c637512-c417-4e78-9d62-b61258e4b619"
  subscription_id = "30434006-d00e-46bc-8717-b0159c94c2c2"
  features {}
  skip_provider_registration = true
}