output "main_region" {
  description = "Region where most resources will be placed"
  value       = var.main_region
}

output "recovery_region" {
  description = "Region where recovery resources will be placed"
  value       = var.recovery_region
}
