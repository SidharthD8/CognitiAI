data "azurerm_client_config" "current" {}

locals {
  private_endpoints_subnet_id = module.vnet.subnets[var.vnet.private_endpoint_subnet_key].resource_id
  infrastructure_subnet_id    = module.vnet.subnets["sub-workloads"].resource_id
}
