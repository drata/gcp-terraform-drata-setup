output "drata_service_account_key" {
  value       = try(base64decode(google_service_account_key.drata_key[0].private_key), "Key managed outside Terraform - provide to Drata manually")
  description = "Service Account Key. Only populated when create_service_account_key is true. When false, create the key manually in GCP Console and provide it to Drata directly."
  sensitive   = true
}
