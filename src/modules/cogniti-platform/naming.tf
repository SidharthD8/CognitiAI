locals {
  prefix              = "insight"
  project             = "cog"
  environment_name    = "dev"
  location_identifier = "ae"

  resource_name_naming_convention = {
    prefix = format("%s-%s-%s-%s", // prefix-project-env-Location-type-number
      local.prefix,                // insight
      local.project,               // cog
      local.environment_name,      // dev
      local.location_identifier,   // ae
    )
    suffix = ""
  }

  resource_group_name_prefix = format("%s-%s-%s-%s", // prefix-project-env-rg-name
    local.prefix,                                    // insight
    local.project,                                   // cog
    local.environment_name,                          // dev
    local.resource_type_names.resource_group         // rg
  )

}
