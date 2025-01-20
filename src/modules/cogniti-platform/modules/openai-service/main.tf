module "openai_service_account" {
  source = "Azure/avm-res-cognitiveservices-account/azurerm"
  #insert the 5 required variables here
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "OpenAI"
  sku_name            = var.sku_name
  name                = var.name

  storage                       = var.storage
  private_endpoints             = var.private_endpoints
  diagnostic_settings           = var.diagnostic_settings
  public_network_access_enabled = var.public_network_access_enabled
  role_assignments              = var.role_assignments

  tags = var.tags
}
