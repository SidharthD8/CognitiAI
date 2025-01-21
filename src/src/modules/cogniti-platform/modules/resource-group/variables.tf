# Define variables
variable "resource_group_name" {
  type        = string
  description = "Name of the Azure resource group"
}

variable "location" {
  type        = string
  description = "Location for the Azure resource group"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the Azure resource group"
}
