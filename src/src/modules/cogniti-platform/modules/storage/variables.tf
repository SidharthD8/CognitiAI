# variables.tf

# Define variables for storage module
variable "name" {
  description = "The name of the storage account"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account"
  type        = string

}

variable "location" {

}

variable "account_kind" {
  description = "The kind of the storage account"
  type        = string
  default     = "StorageV2"
}
variable "account_tier" {
  default     = "Standard"
  description = "value of the storage account tier"
}
variable "account_replication_type" {
  description = "The replication type of the storage account"
  type        = string
  default     = "RAGZRS"
}

variable "containers" {
  description = "The list of containers to create in the storage account"
  type        = list(string)
  default     = []

}

variable "tags" {
  description = "Tags to apply to the storage account"
  type        = map(string)
}

variable "private_endpoints" {
  type = map(object({
    name = optional(string, null)
    role_assignments = optional(map(object({
      role_definition_id_or_name       = string
      principal_id                     = string
      description                      = optional(string, null)
      skip_service_principal_aad_check = optional(bool, false)
      condition                        = optional(string, null)
      condition_version                = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null) }
      )),
    {})
    lock = optional(object({ name = optional(string, null)
    kind = optional(string, null) }), {})
    tags                                    = optional(map(any), null)
    subnet_resource_id                      = string
    subresource_name                        = string
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    inherit_tags                            = optional(bool, false)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name = string
      private_ip_address = string })),
    {})
  }))
  description = "Private endpoints for the storage account"
  default     = null
}


variable "allowed_copy_scope" {
  type        = string
  default     = null
  description = "(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are `AAD` and `PrivateLink`."
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should cross Tenant replication be enabled? Defaults to `false`."
}

variable "large_file_share_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Is Large File Share Enabled?"
}

variable "is_hns_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 ([see here for more information](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-quickstart-create-account/)). Changing this forces a new resource to be created."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether or not public network access is allowed for this storage account. Defaults to `false`."
}

variable "is_versioning_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is versioning enabled for this storage account? Defaults to `false`."
}

variable "is_change_feed_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is change feed enabled for this storage account? Defaults to `false`."
}

variable "is_last_access_time_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is last access time enabled for this storage account? Defaults to `false`."
}

variable "publish_microsoft_endpoints" {
  type        = bool
  default     = false
  description = "(Optional) Should Microsoft routing storage endpoints be published? Defaults to `false`."
}

variable "default_to_oauth_authentication" {
  type        = bool
  default     = false
  description = "(Optional) Should the storage account default to OAuth authentication? Defaults to `false`."

}

variable "is_use_system_assigned_identity" {
  default = false
}

variable "diagnostic_settings_blob" {
  type = map(object({
    name                  = string
    workspace_resource_id = optional(string, null)
    log_categories        = optional(set(string), [])
    log_groups            = optional(set(string), ["allLogs"])
    metric_categories     = optional(set(string), [])
  }))
  default = {}
}

variable "diagnostic_settings_queue" {
  type = map(object({
    name                  = string
    workspace_resource_id = optional(string, null)
    log_categories        = optional(set(string), [])
    log_groups            = optional(set(string), ["allLogs"])
    metric_categories     = optional(set(string), [])
  }))
  default = {}
}

variable "diagnostic_settings_table" {
  type = map(object({
    name                  = string
    workspace_resource_id = optional(string, null)
    log_categories        = optional(set(string), [])
    log_groups            = optional(set(string), ["allLogs"])
    metric_categories     = optional(set(string), [])
  }))
  default = {}
}

variable "diagnostic_settings_file" {
  type = map(object({
    name                  = string
    workspace_resource_id = optional(string, null)
    log_categories        = optional(set(string), [])
    log_groups            = optional(set(string), ["allLogs"])
    metric_categories     = optional(set(string), [])
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
