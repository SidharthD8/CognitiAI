terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74.0"
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
# Default provider configuration for azurerm
provider "azurerm" {
  features {}
  storage_use_azuread = true
}

# Aliased provider configuration for azurerm with a specific tenant and subscription
provider "azurerm" {
  alias            = "Cogniti"
  tenant_id        = "6c637512-c417-4e78-9d62-b61258e4b619"
  subscription_id  = "30434006-d00e-46bc-8717-b0159c94c2c2"
  features {}
  skip_provider_registration = true
}