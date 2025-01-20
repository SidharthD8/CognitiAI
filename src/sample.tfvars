
vnet = {
  address_space               = "10.234.0.0/16"
  private_endpoint_subnet_key = "sub-private-endpoints"
  subnets = {
    sub-private-endpoints = {
      name                      = "private-endpoints"
      address_prefixes          = ["10.234.0.0/27"]
      is_connect_to_route_table = false
      service_endpoints         = []
      security_group_rules      = []
    }
    sub-workloads = {
      name              = "workloads"
      address_prefixes  = ["10.234.2.0/23"]
      service_endpoints = []
      security_group_rules = [{
        name                       = "Allow-Workloads-From-Private-Subnet"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }]
    }
  }
  diagnostic_settings = {
    "diagnostics" = {
      log_categories    = []
      log_groups        = ["allLogs"]
      metric_categories = []
    }
  }
}


storage_accounts = {
  storage_account_1 = {
    index                    = "01"
    name                     = "storage"
    account_tier             = "Standard"
    account_kind             = "StorageV2"
    account_replication_type = "LRS"
    containers               = ["container1", "container2"]
    private_endpoints = {
      "blob" = {
        subresource_name = "blob"
      }
    }
  }
}


log_analytics = {
  sku               = "PerGB2018"
  retention_in_days = 30
}
