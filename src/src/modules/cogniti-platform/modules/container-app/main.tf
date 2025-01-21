module "avm-res-app-containerapp" {
  source                                = "Azure/avm-res-app-containerapp/azurerm"
  name                                  = var.name
  resource_group_name                   = var.resource_group_name
  revision_mode                         = var.revision_mode
  tags                                  = var.tags
  workload_profile_name                 = var.workload_profile_name
  template                              = var.template
  role_assignments                      = var.role_assignments
  managed_identities                    = var.managed_identities
  auth_configs                          = var.auth_configs
  container_app_environment_resource_id = var.container_app_environment_resource_id
  enable_telemetry                      = var.enable_telemetry
  secrets                               = var.secrets
  registries                            = var.registries
  ingress                               = var.ingress
}
