module "search_service" {
  source = "Azure/avm-res-search-searchservice/azurerm"
  #insert the 6 required variables here
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  replica_count       = var.replica_count
  partition_count     = var.partition_count
  name                = var.name
}
