output "drata_service_account_key" {
  value       = base64decode(google_service_account_key.drata_key.private_key)
  description = "Service Account Key"
  sensitive   = true
}
