output "resource_group_id" {
  value       = azurerm_resource_group.rg.id
  description = "ID of the created Azure resource group"
}

output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Name of the created Azure resource group"
}

output "resource_group_location" {
  value       = azurerm_resource_group.rg.location
  description = "Location of the created Azure resource group"
}

output "resource_group_tags" {
  value       = azurerm_resource_group.rg.tags
  description = "Tags of the created Azure resource group"
}
