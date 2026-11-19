variable "gcp_project_id" {
  type        = string
  description = "Project identifier of the gcp organization. If it is not provided, the provider project is used."
  default     = null
}

variable "gcp_org_domain" {
  type        = string
  description = "GCP Organization domain."
}

variable "connect_multiple_projects" {
  type        = bool
  description = "Tells the service account whether it can see all the projects or not."
  default     = true
}

variable "sync_all_projects_users" {
  type        = bool
  description = "Lets the service account read the IAM policy of every project in the organization, so Drata can sync IAM users from all projects for access reviews. Also turn on 'Sync IAM users from all projects in the organization' on the GCP connection in Drata."
  default     = false
}

variable "gcp_services" {
  type        = list(string)
  default     = ["cloudresourcemanager.googleapis.com", "compute.googleapis.com", "admin.googleapis.com", "sqladmin.googleapis.com", "monitoring.googleapis.com", "cloudasset.googleapis.com"]
  description = "List of services to enable."
}

variable "drata_role_name" {
  type        = string
  description = "Role name."
  default     = "DrataReadOnly"
}

variable "create_service_account_key" {
  type        = bool
  description = "Whether to create a service account key and expose it as an output. Set to false when the key will be created manually outside of Terraform to avoid storing credentials in state."
  default     = true
}
