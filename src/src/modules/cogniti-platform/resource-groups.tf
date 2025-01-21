module "rg-frontend" {
  source              = "./modules/resource-group"
  location            = var.location
  resource_group_name = "${local.resource_group_name_prefix}-front-end"
  tags                = var.tags
}

module "rg-ai-services" {
  source              = "./modules/resource-group"
  location            = var.location
  resource_group_name = "${local.resource_group_name_prefix}-ai-services"
  tags                = var.tags
}

module "rg-data" {
  source              = "./modules/resource-group"
  location            = var.location
  resource_group_name = "${local.resource_group_name_prefix}-data"
  tags                = var.tags
}

module "rg-network" {
  source              = "./modules/resource-group"
  location            = var.location
  resource_group_name = "${local.resource_group_name_prefix}-network"
  tags                = var.tags

}
