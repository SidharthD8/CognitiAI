output "resource_id" {
  value = module.log_analytics_workspace.resource_id
}

output "workspace_resource" {
  value = module.log_analytics_workspace.resource

}

output "workspace_primary_key" {
  value = module.log_analytics_workspace.resource.primary_shared_key
}

output "workspace_secondary_key" {
  value = module.log_analytics_workspace.resource.secondary_shared_key
}

output "workspace_id" {
  value = module.log_analytics_workspace.resource.workspace_id
}
