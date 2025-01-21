module "search_service" {
  source = "./modules/search-service"
  #insert the 6 required variables here
  resource_group_name = module.rg-ai-services.resource_group_name
  location            = var.location
  sku                 = var.ai_services.search_service.sku
  replica_count       = var.ai_services.search_service.replica_count
  partition_count     = var.ai_services.search_service.partition_count
  name                = trim(format("%s-%s-%s", local.resource_name_naming_convention.prefix, local.resource_type_names.search_service, local.resource_name_naming_convention.suffix), "-")
}
