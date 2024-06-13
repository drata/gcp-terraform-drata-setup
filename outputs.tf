output "drata_service_account_key" {
  value       = base64decode(google_service_account_key.drata_key.private_key)
  description = "Service Account Key"
  sensitive   = true
}

output "drata_service_account" {
  value       = google_service_account.drata.email
  description = "Service Account Object"
}
