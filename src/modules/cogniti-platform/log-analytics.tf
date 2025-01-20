module "log_analytics_workspace" {
  count                                     = var.log_analytics != null && var.existing_log_analytics_workspace_resource_id == null ? 1 : 0
  source                                    = "./modules/log-analytics"
  location                                  = var.location
  resource_group_name                       = module.rg-data.resource_group_name
  name                                      = trim(format("%s-%s-%s", local.resource_name_naming_convention.prefix, local.resource_type_names.log_analytics_workspace, local.resource_name_naming_convention.suffix), "-")
  log_analytics_workspace_retention_in_days = var.log_analytics.retention_in_days
  sku                                       = var.log_analytics.sku
  log_analytics_workspace_identity = {
    type = "SystemAssigned"
  }
  #   role_assignments  = var.log_analytics.role_assignments
  #   private_endpoints = var.log_analytics.private_endpoints
  tags = var.tags
}

locals {
  log_analytics_workspace_resource_id = var.existing_log_analytics_workspace_resource_id != null ? (
    var.existing_log_analytics_workspace_resource_id) : (
  var.log_analytics != null ? module.log_analytics_workspace[0].resource_id : null)
}
