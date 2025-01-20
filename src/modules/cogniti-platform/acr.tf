module "acr" {
  source                  = "./modules/acr"
  location                = var.location
  name                    = replace(format("%s%s%s", local.resource_name_naming_convention.prefix, local.resource_type_names.container_registry, local.resource_name_naming_convention.suffix), "-", "")
  resource_group_name     = module.rg-frontend.resource_group_name
  sku                     = var.acr.sku
  admin_enabled           = var.acr.admin_enabled
  tags                    = var.tags
  zone_redundancy_enabled = var.acr.zone_redundancy_enabled

  managed_identities = {
    system_assigned = true
    user_assigned_resource_ids = [
      azurerm_user_assigned_identity.keyvault_identity.id
    ]
  }

  private_endpoints = {
    primary = {
      name                            = trim(format("%s-%s-%s", local.resource_name_naming_convention.prefix, local.resource_type_names.storage_account, local.resource_type_names.private_endpoint), "-")
      subnet_resource_id              = local.private_endpoints_subnet_id
      tags                            = var.tags
      private_service_connection_name = trim(format("%s-%s-%s-%s", local.resource_name_naming_convention.prefix, local.resource_type_names.storage_account, local.resource_type_names.private_endpoint, local.resource_type_names.private_service_connection), "-")
      network_interface_name          = trim(format("%s-%s-%s", local.resource_name_naming_convention.prefix, local.resource_type_names.storage_account, local.resource_type_names.network_interface), "-")
      resource_group_name             = module.rg-network.resource_group_name
      inherit_tags                    = true
    }
  }

  role_assignments = {
    acr_pull = {
      principal_id               = azurerm_user_assigned_identity.keyvault_identity.principal_id
      role_definition_id_or_name = "AcrPull"
    }
  }
}

resource "azurerm_user_assigned_identity" "keyvault_identity" {
  name                = format("%s-%s-%s", local.resource_name_naming_convention.prefix, local.resource_type_names.user_assigned_identity, local.resource_name_naming_convention.suffix)
  resource_group_name = module.rg-frontend.resource_group_name
  location            = var.location
}
