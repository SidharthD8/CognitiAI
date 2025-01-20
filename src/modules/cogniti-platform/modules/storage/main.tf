module "avm-res-storage-storageaccount" {
  source                   = "Azure/avm-res-storage-storageaccount/azurerm"
  name                     = var.name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  private_endpoints        = var.private_endpoints
  tags                     = var.tags
  managed_identities = {
    system_assigned = var.is_use_system_assigned_identity
  }
  enable_telemetry = false

  blob_properties = {
    versioning_enabled       = var.is_versioning_enabled
    change_feed_enabled      = var.is_change_feed_enabled
    last_access_time_enabled = var.is_last_access_time_enabled
  }

  routing = {
    publish_microsoft_endpoints = var.publish_microsoft_endpoints
  }

  public_network_access_enabled    = var.public_network_access_enabled
  allowed_copy_scope               = var.allowed_copy_scope
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  containers                       = local.containers
  large_file_share_enabled         = var.large_file_share_enabled
  is_hns_enabled                   = var.is_hns_enabled
  default_to_oauth_authentication  = true
  # insert the 2 required variables here

  diagnostic_settings_blob  = var.diagnostic_settings_blob
  diagnostic_settings_file  = var.diagnostic_settings_file
  diagnostic_settings_queue = var.diagnostic_settings_queue
  diagnostic_settings_table = var.diagnostic_settings_table

  role_assignments = var.role_assignments
}

locals {
  containers = {
    for container in var.containers : container => {
      name = container
    }
  }
}
