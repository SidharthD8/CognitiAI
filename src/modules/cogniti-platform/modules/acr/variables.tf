variable "location" {
  type        = string
  description = "Azure region where the resource should be deployed."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name of the Container Registry."

  validation {
    condition     = can(regex("^[[:alnum:]]{5,50}$", var.name))
    error_message = "The name must be between 5 and 50 characters long and can only contain letters and numbers."
  }
}

# This is required for most resource modules
variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources will be deployed."
}

variable "sku" {
  type    = string
  default = "Premium"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The SKU name must be either `Basic`, `Standard` or `Premium`."
  }
  description = "The SKU name of the Container Registry. Default is `Premium`. `Possible values are `Basic`, `Standard` and `Premium`."
}

variable "admin_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether the admin user is enabled. Defaults to `false`."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether public access is permitted."
}


variable "quarantine_policy_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether the quarantine policy is enabled."
}

variable "zone_redundancy_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether zone redundancy is enabled.  Modifying this forces a new resource to be created."
}

variable "export_policy_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether export policy is enabled. Defaults to true. In order to set it to false, make sure the public_network_access_enabled is also set to false."
}

variable "anonymous_pull_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether anonymous (unauthenticated) pull access to this Container Registry is allowed.  Requries Standard or Premium SKU."
}

variable "data_endpoint_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether to enable dedicated data endpoints for this Container Registry.  Requires Premium SKU."
}

variable "network_rule_bypass_option" {
  type    = string
  default = "None"
  validation {
    condition     = var.network_rule_bypass_option == null ? true : contains(["AzureServices", "None"], var.network_rule_bypass_option)
    error_message = "The network_rule_bypass_option variable must be either `AzureServices` or `None`."
  }
  description = <<DESCRIPTION
Specifies whether to allow trusted Azure services access to a network restricted Container Registry.  
Possible values are `None` and `AzureServices`. Defaults to `None`.
DESCRIPTION
}

variable "georeplications" {
  type = list(object({
    location                  = string
    regional_endpoint_enabled = optional(bool, true)
    zone_redundancy_enabled   = optional(bool, true)
    tags                      = optional(map(any), null)
  }))
  default     = []
  description = <<DESCRIPTION
A list of geo-replication configurations for the Container Registry.

- `location` - (Required) The geographic location where the Container Registry should be geo-replicated.
- `regional_endpoint_enabled` - (Optional) Enables or disables regional endpoint. Defaults to `true`.
- `zone_redundancy_enabled` - (Optional) Enables or disables zone redundancy. Defaults to `true`.
- `tags` - (Optional) A map of additional tags for the geo-replication configuration. Defaults to `null`.

DESCRIPTION
}

variable "network_rule_set" {
  type = object({
    default_action = optional(string, "Deny")
    ip_rule = optional(list(object({
      # since the `action` property only permits `Allow`, this is hard-coded.
      action   = optional(string, "Allow")
      ip_range = string
    })), [])
    virtual_network = optional(list(object({
      # since the `action` property only permits `Allow`, this is hard-coded.
      action    = optional(string, "Allow")
      subnet_id = string
    })), [])
  })
  default = null
  validation {
    condition     = var.network_rule_set == null ? true : contains(["Allow", "Deny"], var.network_rule_set.default_action)
    error_message = "The default_action value must be either `Allow` or `Deny`."
  }
  description = <<DESCRIPTION
The network rule set configuration for the Container Registry.
Requires Premium SKU.

- `default_action` - (Optional) The default action when no rule matches. Possible values are `Allow` and `Deny`. Defaults to `Deny`.
- `ip_rules` - (Optional) A list of IP rules in CIDR format. Defaults to `[]`.
  - `action` - Only "Allow" is permitted
  - `ip_range` - The CIDR block from which requests will match the rule.
- `virtual_network` - (Optional) When using with Service Endpoints, a list of subnet IDs to associate with the Container Registry. Defaults to `[]`.
  - `action` - Only "Allow" is permitted
  - `subnet_id` - The subnet id from which requests will match the rule.

DESCRIPTION
}

variable "retention_policy" {
  type = object({
    days    = optional(number, 7)
    enabled = optional(bool, false)
  })
  default     = {}
  description = <<DESCRIPTION
If enabled, this retention policy will purge an untagged manifest after a specified number of days.  

- `days` - (Optional) The number of days before the policy Defaults to 7 days.
- `enabled` - (Optional) Whether the retention policy is enabled.  Defaults to false.

DESCRIPTION
}


variable "private_endpoints" {
  type = map(object({
    name = optional(string, null)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })), {})
    lock = optional(object({
      kind = string
      name = optional(string, null)
    }), null)
    tags                                    = optional(map(string), null)
    subnet_resource_id                      = string
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name               = string
      private_ip_address = string
    })), {})
  }))
  default = {}
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default = {}
}

variable "diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default = {}
}

variable "managed_identities" {
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
  default = {}
}

variable "tags" {

}
