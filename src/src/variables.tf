
variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "australiaeast"
}

variable "search_service_properties" {
  type = object({
    sku             = string
    replica_count   = number
    partition_count = number
  })
  default = {
    sku             = "basic"
    replica_count   = 1
    partition_count = 1
  }
}

variable "openai_service_account_properties" {
  type = object({
    sku_name = string
  })
  default = {
    sku_name = "S0"
  }
}

variable "speech_service_account_properties" {
  type = object({
    sku_name = string
  })
  default = {
    sku_name = "S0"
  }
}

variable "vnet" {
  type = object({
    address_space               = string
    private_endpoint_subnet_key = string
    subnets = map(object({
      name                      = string
      address_prefixes          = list(string)
      is_connect_to_route_table = optional(bool, true)
      service_endpoints         = optional(list(string), null)
      security_group_rules = optional(list(object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
      })), null)
    }))
    hub_network_config = optional(object({
      remote_subscription_id         = string
      remote_vnet_name               = string
      remote_resource_group_name     = string
      remote_allow_forwarded_traffic = optional(bool, true)
      remote_allow_gateway_transit   = optional(bool, true)
      remote_use_remote_gateways     = optional(bool, false)
      allow_forwarded_traffic        = optional(bool, true)
      allow_gateway_transit          = optional(bool, false)
      use_remote_gateways            = optional(bool, true)
    }), null)
    route_table = optional(object({
      name                          = string
      disable_bgp_route_propagation = optional(bool, true)
      routes = map(object({
        name                   = string
        address_prefix         = string
        next_hop_type          = string
        next_hop_in_ip_address = string
      }))
    }), null)
    diagnostic_settings = optional(map(object({
      log_categories    = optional(set(string), [])
      log_groups        = optional(set(string), ["allLogs"])
      metric_categories = optional(set(string), [])
    })), {})
  })
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "storage_accounts" {
  type = map(object({
    name                             = string
    index                            = optional(string, "01")
    account_tier                     = string
    account_kind                     = string
    account_replication_type         = string
    is_use_system_assigned_identity  = optional(bool, null)
    is_last_access_time_enabled      = optional(bool, null)
    cross_tenant_replication_enabled = optional(bool, null)
    is_hns_enabled                   = optional(bool, null)
    default_to_oauth_authentication  = optional(bool, null)
    is_versioning_enabled            = optional(bool, null)
    publish_microsoft_endpoints      = optional(bool, null)
    large_file_share_enabled         = optional(bool, null)
    is_change_feed_enabled           = optional(bool, null)
    containers                       = optional(list(string), null)
    private_endpoints = optional(map(object({
      subresource_name   = string
      private_ip_address = optional(string, null)
    })), null)
    diagnostic_settings_blob = optional(map(object({
      log_categories    = optional(set(string), [])
      log_groups        = optional(set(string), ["allLogs"])
      metric_categories = optional(set(string), [])
    })), {})
    diagnostic_settings_queue = optional(map(object({
      log_categories    = optional(set(string), [])
      log_groups        = optional(set(string), ["allLogs"])
      metric_categories = optional(set(string), [])
    })), {})
    diagnostic_settings_table = optional(map(object({
      log_categories    = optional(set(string), [])
      log_groups        = optional(set(string), ["allLogs"])
      metric_categories = optional(set(string), [])
    })), {})
    diagnostic_settings_file = optional(map(object({
      log_categories    = optional(set(string), [])
      log_groups        = optional(set(string), ["allLogs"])
      metric_categories = optional(set(string), [])
    })), {})
  }))
}

variable "log_analytics" {
  type = object({
    retention_in_days = optional(number, 30)
    sku               = optional(string, "Standard")
    # role_assignments  = optional(list(string), {})
    # private_endpoints = optional(list(string), {})
  })
  default = null
}

variable "existing_log_analytics_workspace_resource_id" {
  type    = string
  default = null
}

variable "ai_services" {
  type = object({
    openai = object({
      sku_name = string
    })
    speech_service = object({
      sku_name = string
    })
    search_service = object({
      sku             = string
      replica_count   = number
      partition_count = number
    })
  })
  default = {
    openai = {
      sku_name = "S0"
    }
    speech_service = {
      sku_name = "S0"
    }
    search_service = {
      sku             = "basic"
      replica_count   = 1
      partition_count = 1
    }
  }
}

variable "container_app" {
  type = object({
    revision_mode = optional(string, "Single")
    template = object({
      max_replicas = optional(number)
      min_replicas = optional(number)
      containers = list(object({
        cpu    = number
        image  = string
        memory = string
        name   = string
      }))
    })
    acr = object({
      secret_name = string
      username    = string
    })
  })
  default = {
    revision_mode = "Single"
    template = {
      containers = [{
        cpu    = 0.25
        image  = "nginx"
        memory = "0.5Gi"
        name   = "nginx"
        }
      ]
    }
    acr = {
      secret_name = ""
      username    = ""
    }
  }
}

variable "acr" {
  type = object({
    sku                      = string
    admin_enabled            = optional(bool, false)
    private_endpoint_enabled = optional(bool, true)
    zone_redundancy_enabled  = optional(bool, false)
  })
  default = {
    sku                      = "Premium"
    admin_enabled            = false
    private_endpoint_enabled = true
    zone_redundancy_enabled  = false
  }
}
