# resource "azurerm_virtual_network_peering" "hub_to_spoke" {
#   for_each                     = var.hub_network_config
#   provider                     = azurerm.hub
#   name                         = "${split("/", each.value.remote_vnet_id)[8]}-to-${var.name}"
#   resource_group_name          = split("/", each.value.remote_vnet_id)[4]
#   virtual_network_name         = split("/", each.value.remote_vnet_id)[8]
#   remote_virtual_network_id    = module.avm-res-network-virtualnetwork.virtual_network_id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic      = true
#   allow_gateway_transit        = true
#   use_remote_gateways          = false
# }


provider "azurerm" {
  features {}
  #   subscription_id            = split("/", var.hub_network_config[keys(var.hub_network_config)[0]].remote_vnet_id)[2]
  subscription_id            = "f2ca8d26-fd17-416e-a830-20bf5d0432b6"
  alias                      = "hub"
  skip_provider_registration = true
}
