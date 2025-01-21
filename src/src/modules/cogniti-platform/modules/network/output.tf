output "vnet_id" {
  value = module.avm-res-network-virtualnetwork.virtual_network_id
}

output "resource_group_name" {
  value = module.avm-res-network-virtualnetwork.vnet_resource.resource_group_name
}

output "subnets" {
  value = module.avm-res-network-virtualnetwork.subnets
}

output "subnets_nsg_assoctiation" {
  value = merge(azurerm_subnet_network_security_group_association.no_rules_subnet_nsg_association, azurerm_subnet_network_security_group_association.subnet_nsg_association)
}

# output "databricks_public_subnet_id" {
#   value = module.avm-res-network-virtualnetwork.databricks_subnets.public_subnet.id

# }

# output "databricks_public_subnet_nsg_association_id" {
#   # value = azurerm_subnet_network_security_group_association.databricks_subnet_nsg_association[var.databricks_public_subnet.name].id
# }

# output "databricks_private_subnet_nsg_association_id" {
#   value = azurerm_subnet_network_security_group_association.databricks_subnet_nsg_association[var.databricks_private_subnet.name].id
# }


# output "private_endpoints_subnet_name" {
#   value = var.private_endpoints_subnet.name
# }

# output "databricks_public_subnet_name" {
#   value = var.databricks_public_subnet.name
# }

# output "databricks_private_subnet_name" {
#   value = var.databricks_private_subnet.name
# }

# output "databricks_public_subnet_id" {
#   value = module.avm-res-network-virtualnetwork.subnets[var.databricks_public_subnet.name].id

# }

# output "databricks_private_subnet_id" {
#   value = module.avm-res-network-virtualnetwork.subnets[var.databricks_private_subnet.name].id
# }


# output "private_endpoints_subnet_id" {
#   value = module.avm-res-network-virtualnetwork.subnets[var.private_endpoints_subnet.name].id
# }
