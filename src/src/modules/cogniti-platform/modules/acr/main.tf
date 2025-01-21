module "acr" {
  source                        = "Azure/avm-res-containerregistry-registry/azurerm"
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  public_network_access_enabled = var.public_network_access_enabled
  private_endpoints             = var.private_endpoints
  tags                          = var.tags
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option
  managed_identities            = var.managed_identities
  diagnostic_settings           = var.diagnostic_settings
  role_assignments              = var.role_assignments
  zone_redundancy_enabled       = var.zone_redundancy_enabled
}
