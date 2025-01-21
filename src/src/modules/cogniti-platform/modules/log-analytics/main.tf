module "log_analytics_workspace" {
  source                                    = "Azure/avm-res-operationalinsights-workspace/azurerm"
  enable_telemetry                          = false
  location                                  = var.location
  resource_group_name                       = var.resource_group_name
  name                                      = var.name
  log_analytics_workspace_retention_in_days = var.log_analytics_workspace_retention_in_days
  log_analytics_workspace_sku               = var.sku
  log_analytics_workspace_identity          = var.log_analytics_workspace_identity
  role_assignments                          = var.role_assignments
  private_endpoints                         = var.private_endpoints
  tags                                      = var.tags

}

