module "avm-res-network-virtualnetwork" {
  source              = "Azure/avm-res-network-virtualnetwork/azurerm"
  version             = "0.7.1"
  name                = var.name
  resource_group_name = var.resource_group_name
  address_space       = [var.address_space]
  enable_telemetry    = false
  location            = var.location
  subnets             = var.subnets
  diagnostic_settings = var.diagnostic_settings
  tags                = var.tags
}

resource "azurerm_network_security_group" "subnet_nsg" {
  for_each            = local.rules_subnets
  name                = "${var.name}-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.security_group_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  for_each                  = local.rules_subnets
  subnet_id                 = module.avm-res-network-virtualnetwork.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.subnet_nsg[each.key].id
}


resource "azurerm_network_security_group" "no_rules_subnet_nsg" {
  for_each            = local.no_rules_subnets
  name                = "${var.name}-${each.key}-Nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  lifecycle {
    ignore_changes = [
      security_rule
    ]
  }
  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "no_rules_subnet_nsg_association" {
  for_each                  = local.no_rules_subnets
  subnet_id                 = module.avm-res-network-virtualnetwork.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.no_rules_subnet_nsg[each.key].id
}

locals {
  no_rules_subnets = { for k, v in var.subnets : k => v if length(v.security_group_rules) == 0 }
  rules_subnets    = { for k, v in var.subnets : k => v if length(v.security_group_rules) > 0 }
}


# resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
#   for_each = var.diagnostic_settings

#   name                           = each.value.name != null ? each.value.name : "diag-${var.name}"
#   target_resource_id             = azurerm_mssql_server.primary.id
#   eventhub_authorization_rule_id = each.value.event_hub_authorization_rule_resource_id
#   eventhub_name                  = each.value.event_hub_name
#   log_analytics_destination_type = each.value.log_analytics_destination_type
#   log_analytics_workspace_id     = each.value.workspace_resource_id
#   partner_solution_id            = each.value.marketplace_partner_resource_id
#   storage_account_id             = each.value.storage_account_resource_id

#   dynamic "enabled_log" {
#     for_each = each.value.log_categories
#     content {
#       category = enabled_log.value
#     }
#   }
#   dynamic "enabled_log" {
#     for_each = each.value.log_groups
#     content {
#       category_group = enabled_log.value
#     }
#   }
#   dynamic "metric" {
#     for_each = each.value.metric_categories
#     content {
#       category = metric.value
#     }
#   }
# }
