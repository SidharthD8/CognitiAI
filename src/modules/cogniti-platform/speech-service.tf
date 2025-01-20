module "speech_service_account" {
  source = "./modules/speech-service"
  #insert the 5 required variables here
  resource_group_name = module.rg-ai-services.resource_group_name
  location            = var.location
  sku_name            = var.ai_services.speech_service.sku_name
  name                = trim(format("%s-%s-%s", local.resource_name_naming_convention.prefix, local.resource_type_names.speech_service_account, local.resource_name_naming_convention.suffix), "-")
  # storage = [{
  #   storage_account_id = module.storage["storage_account_1"].storage_account_id
  # }]
}
