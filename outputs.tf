output "drata_service_account_key" {
  value       = var.create_service_account_key ? base64decode(google_service_account_key.drata_key[0].private_key) : null
  description = "Service Account Key. Only populated when create_service_account_key is true. When false, create the key outside terraform and provide it to Drata directly."
  sensitive   = true
}

output "drata_service_account_email" {
  value       = google_service_account.drata.email
  description = "Service Account Object"
}
