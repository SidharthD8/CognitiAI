module "vnet" {
  source              = "./modules/vnet"
  location            = var.location
  name                = trim(format("%s-%s-%s", local.resource_name_naming_convention.prefix, local.resource_type_names.virtual_network, local.resource_name_naming_convention.suffix), "-")
  address_space       = var.vnet.address_space
  subnets             = var.vnet.subnets
  resource_group_name = module.rg-network.resource_group_name
  # diagnostic_settings = {
  #   for key, value in var.vnet.diagnostic_settings :
  #   key => {
  #     name                  = key
  #     workspace_resource_id = local.log_analytics_workspace_resource_id
  #     log_categories        = value.log_categories
  #     log_groups            = value.log_groups
  #     metric_categories     = value.metric_categories
  #   }
  # }
  tags = var.tags
}

# module "vnet_peering" {
#   count  = var.vnet.hub_network_config != null ? 1 : 0
#   source = "./modules/vnet-peering"

#   vnet = {
#     vnet_name               = var.vnet.name
#     resource_group_name     = module.vnet.resource_group_name
#     allow_forwarded_traffic = var.vnet.hub_network_config.allow_forwarded_traffic
#     allow_gateway_transit   = var.vnet.hub_network_config.allow_gateway_transit
#     use_remote_gateways     = var.vnet.hub_network_config.use_remote_gateways
#   }

#   remote_vnet = {
#     vnet_name               = var.vnet.hub_network_config.remote_vnet_name
#     resource_group_name     = var.vnet.hub_network_config.remote_resource_group_name
#     allow_forwarded_traffic = var.vnet.hub_network_config.remote_allow_forwarded_traffic
#     allow_gateway_transit   = var.vnet.hub_network_config.remote_allow_gateway_transit
#     use_remote_gateways     = var.vnet.hub_network_config.remote_use_remote_gateways
#   }

#   providers = {
#     azurerm.remote_peering = azurerm.remote_peering
#   }


#   depends_on = [module.vnet]
# }

# provider "azurerm" {
#   features {}
#   subscription_id            = var.vnet.hub_network_config != null ? var.vnet.hub_network_config.remote_subscription_id : null
#   alias                      = "remote_peering"
#   skip_provider_registration = true

# }

# ############## Peering Module ################

# resource "azurerm_route_table" "route_table" {
#   count                         = var.vnet.route_table != null ? 1 : 0
#   name                          = var.vnet.route_table.name
#   location                      = var.location
#   resource_group_name           = module.rg-network.resource_group_name
#   disable_bgp_route_propagation = var.vnet.route_table.disable_bgp_route_propagation
#   dynamic "route" {
#     for_each = var.vnet.route_table.routes
#     content {
#       name                   = route.value.name
#       address_prefix         = route.value.address_prefix
#       next_hop_type          = route.value.next_hop_type
#       next_hop_in_ip_address = route.value.next_hop_in_ip_address
#     }
#   }
#   tags = var.tags

#   depends_on = [module.vnet]
# }

# resource "azurerm_subnet_route_table_association" "subnet_routetable_association" {
#   count          = var.vnet.route_table != null ? length(local.route_table_subnets) : 0
#   subnet_id      = module.vnet.subnets[local.route_table_subnets[count.index]].id
#   route_table_id = azurerm_route_table.route_table[0].id

#   depends_on = [module.vnet]
# }

# locals {
#   # all_subnets = merge(var.vnet.databricks_private_subnet, var.vnet.databricks_public_subnet, var.vnet.subnets.other_subnets, var.vnet.subnets.private_endpoints)

#   # route_table_subnets = {
#   #   for key, value in local.all_subnets :
#   #   key => {
#   #     name = value.name
#   #   }
#   # }
#   # databricks_public_subnet  = var.vnet.subnets.other_subnets != null && (length(var.vnet.subnets.other_subnets) > 0) ? var.vnet.subnets.other_subnets[var.databricks.public_subnet_key] : null
#   # databricks_private_subnet = var.vnet.subnets.other_subnets != null && (length(var.vnet.subnets.other_subnets) > 0) ? var.vnet.subnets.other_subnets[var.databricks.private_subnet_key] : null

#   databricks_private_subnets_keys = [
#     for key, value in var.databricks : value.private_subnet_key
#   ]
#   databricks_public_subnets_keys = [
#     for key, value in var.databricks : value.public_subnet_key
#   ]

#   databricks_subnets_keys = concat(local.databricks_private_subnets_keys, local.databricks_public_subnets_keys)

#   # https://discuss.hashicorp.com/t/conditionally-create-resources-when-a-for-each-loop-is-involved/20841
#   all_subnets = {
#     for key, value in var.vnet.subnets :
#     key => {
#       address_prefixes     = value.address_prefixes
#       service_endpoints    = value.service_endpoints
#       security_group_rules = value.security_group_rules

#       delegations = contains(local.databricks_subnets_keys, key) ? [{
#         name = "databricks"
#         service_delegation = {
#           name = "Microsoft.Databricks/workspaces"
#           actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
#           "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
#         }
#       }] : []
#     }
#   }

#   route_table_subnets = [for key, value in var.vnet.subnets : key if value.is_connect_to_route_table == true]
# }
