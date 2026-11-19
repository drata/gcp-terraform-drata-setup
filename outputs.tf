output "drata_service_account_key" {
  value       = var.create_service_account_key ? base64decode(google_service_account_key.drata_key[0].private_key) : null
  description = "Service Account Key. Only populated when create_service_account_key is true. When false, create the key outside terraform and provide it to Drata directly."
  sensitive   = true
}

output "sync_all_projects_users" {
  value       = var.sync_all_projects_users
  description = "Whether the service account can read every project's IAM policy. When true, turn on 'Sync IAM users from all projects in the organization' on the GCP connection in Drata."
}
