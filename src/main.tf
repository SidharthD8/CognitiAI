module "cogniti-platform" {
  source                                       = "./modules/cogniti-platform"
  location                                     = var.location
  tags                                         = var.tags
  storage_accounts                             = var.storage_accounts
  vnet                                         = var.vnet
  log_analytics                                = var.log_analytics
  existing_log_analytics_workspace_resource_id = var.existing_log_analytics_workspace_resource_id
  ai_services                                  = var.ai_services
  container_app                                = var.container_app
  acr                                          = var.acr
}
