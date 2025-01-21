module "storage" {
  for_each                 = var.storage_accounts
  source                   = "./modules/storage"
  name                     = lower(replace(format("%s%s%s%s", local.resource_name_naming_convention.prefix, local.resource_type_names.storage_account, local.resource_name_naming_convention.suffix, each.value.index + 1), "-", ""))
  resource_group_name      = module.rg-data.resource_group_name
  location                 = var.location
  account_tier             = each.value.account_tier
  account_kind             = each.value.account_kind
  account_replication_type = each.value.account_replication_type
  containers               = each.value.containers
  #TODO: to be removed
  public_network_access_enabled = true
  tags                          = var.tags

  private_endpoints = {
    for key, instance in each.value.private_endpoints : key => {
      name                            = trim(format("%s-%s-%s-%s-%s-%s", local.resource_name_naming_convention.prefix, each.value.name, local.resource_type_names.storage_account, each.value.index, instance.subresource_name, local.resource_type_names.private_endpoint), "-")
      subnet_resource_id              = local.private_endpoints_subnet_id
      tags                            = var.tags
      private_service_connection_name = trim(format("%s-%s-%s-%s-%s-%s-%s", local.resource_name_naming_convention.prefix, each.value.name, local.resource_type_names.storage_account, each.value.index, instance.subresource_name, local.resource_type_names.private_endpoint, local.resource_type_names.private_service_connection), "-")
      network_interface_name          = trim(format("%s-%s-%s-%s-%s-%s", local.resource_name_naming_convention.prefix, each.value.name, local.resource_type_names.storage_account, each.value.index, instance.subresource_name, local.resource_type_names.network_interface), "-")
      subresource_name                = instance.subresource_name
      resource_group_name             = module.rg-network.resource_group_name
      inherit_tags                    = true

      ip_configurations = instance.private_ip_address != null ? {
        private_endpoint = {
          name               = "pe_config"
          private_ip_address = instance.private_ip_address
        }
      } : null
    }
  }
  is_use_system_assigned_identity  = each.value.is_use_system_assigned_identity
  is_last_access_time_enabled      = each.value.is_last_access_time_enabled
  cross_tenant_replication_enabled = each.value.cross_tenant_replication_enabled
  is_hns_enabled                   = each.value.is_hns_enabled
  default_to_oauth_authentication  = each.value.default_to_oauth_authentication
  is_versioning_enabled            = each.value.is_versioning_enabled
  publish_microsoft_endpoints      = each.value.publish_microsoft_endpoints
  large_file_share_enabled         = each.value.large_file_share_enabled
  is_change_feed_enabled           = each.value.is_change_feed_enabled

  diagnostic_settings_blob = {
    for key, value in each.value.diagnostic_settings_blob :
    key => {
      name                  = key
      workspace_resource_id = local.log_analytics_workspace_resource_id
      log_categories        = value.log_categories
      log_groups            = value.log_groups
      metric_categories     = value.metric_categories
    }
  }

  diagnostic_settings_file = {
    for key, value in each.value.diagnostic_settings_file :
    key => {
      name                  = key
      workspace_resource_id = local.log_analytics_workspace_resource_id
      log_categories        = value.log_categories
      log_groups            = value.log_groups
      metric_categories     = value.metric_categories
    }
  }

  diagnostic_settings_queue = {
    for key, value in each.value.diagnostic_settings_queue :
    key => {
      name                  = key
      workspace_resource_id = local.log_analytics_workspace_resource_id
      log_categories        = value.log_categories
      log_groups            = value.log_groups
      metric_categories     = value.metric_categories
    }
  }

  diagnostic_settings_table = {
    for key, value in each.value.diagnostic_settings_table :
    key => {
      name                  = key
      workspace_resource_id = local.log_analytics_workspace_resource_id
      log_categories        = value.log_categories
      log_groups            = value.log_groups
      metric_categories     = value.metric_categories
    }
  }

  # role_assignments = local.databricks_connector_role_assignments

}

locals {

}

# locals {
#   databricks_connector_role_assignments = {
#     for key, value in azurerm_databricks_access_connector.access_connector :
#     key => {
#       role_definition_id_or_name = "Storage Blob Data Contributor"
#       principal_id               = value.identity[0].principal_id
#     }

#   }
# }
