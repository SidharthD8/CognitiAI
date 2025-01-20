
variable "resource_group_name" {
  description = "The name of the resource group in which to create the search service."
  type        = string
}

variable "location" {
  description = "The location/region where the search service is created."
  type        = string
}

variable "sku" {
  description = "The SKU of the search service."
  type        = string
}

variable "replica_count" {
  description = "The number of replicas to create for the search service."
  type        = number
}

variable "partition_count" {
  description = "The number of partitions to create for the search service."
  type        = number
}

variable "name" {
  description = "The name of the search service."
  type        = string
}
