output "definition_id" {
  value       = crczp_sandbox_definition.definition.id
  description = "Id of created sandbox definition."
}

output "pool_id" {
  value       = crczp_sandbox_pool.pool.id
  description = "Id of created sandbox pool."
}

output "sandbox_ids" {
  value       = crczp_sandbox_allocation_unit.sandbox[*].id
  description = "List of ids of created sandboxes."
}

