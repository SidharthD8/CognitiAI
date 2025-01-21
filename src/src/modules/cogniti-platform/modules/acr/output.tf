output "id" {
  value = module.acr.resource_id
}

output "login_server" {
  value = module.acr.resource.login_server
}

output "identity" {
  value = module.acr.resource.identity[0].principal_id
}
