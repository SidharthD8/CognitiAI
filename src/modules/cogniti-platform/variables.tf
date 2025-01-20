
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
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "storage_accounts" {
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

variable "ai_services" {}


variable "container_app" {
}

variable "acr" {
}

