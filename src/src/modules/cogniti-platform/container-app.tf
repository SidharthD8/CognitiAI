# https://registry.terraform.io/modules/Azure/avm-res-app-containerapp/azurerm/latest/examples/acr

resource "azurerm_container_app_environment" "environment" {
  location                 = var.location
  name                     = trim(format("%s-%s-%s", local.resource_name_naming_convention.prefix, local.resource_type_names.container_app_environment, local.resource_name_naming_convention.suffix), "-")
  resource_group_name      = module.rg-frontend.resource_group_name
  infrastructure_subnet_id = local.infrastructure_subnet_id

  depends_on = [module.vnet]
}

module "container_apps" {
  source = "./modules/container-app"

  resource_group_name                   = module.rg-frontend.resource_group_name
  container_app_environment_resource_id = azurerm_container_app_environment.environment.id
  name                                  = trim(format("%s-%s-%s", local.resource_name_naming_convention.prefix, local.resource_type_names.container_app, local.resource_name_naming_convention.suffix), "-")
  revision_mode                         = var.container_app.revision_mode
  template = {

    containers = [for container in var.container_app.template.containers : {
      name   = container.name
      image  = "${module.acr.login_server}/${container.image}"
      cpu    = container.cpu
      memory = container.memory
      # port                  = container.port
      # environment_variables = container.environment_variables
      }
    ]
  }

  registries = [
    {
      #TODO: This line needs to be fixed
      identity = azurerm_user_assigned_identity.keyvault_identity.id
      server   = module.acr.login_server
    }
  ]
  ingress = {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 80
    traffic_weight = [
      {
        latest_revision = true
        percentage      = 100
      }
    ]
  }

  #   secrets = {
  #     nginx = {
  #       name  = "secname"
  #       value = azurerm_container_registry_token_password.pulltokenpassword.password1[0].value
  #     }
  #   }
  #   depends_on = [null_resource.docker_push]
}
