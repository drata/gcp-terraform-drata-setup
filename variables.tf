variable "gcp_project_id" {
  type        = string
  description = "Project identifier of the gcp organization. If it is not provided, the provider project is used."
  default     = null
}

variable "gcp_org_domain" {
  type        = string
  description = "GCP Organization domain."
}

variable "gcp_services" {
  type        = list(string)
  default     = ["cloudresourcemanager.googleapis.com", "compute.googleapis.com", "admin.googleapis.com", "sqladmin.googleapis.com", "monitoring.googleapis.com"]
  description = "List of services to enable."
}

variable "drata_role_name" {
  type        = string
  description = "Role name."
  default     = "DrataReadOnly"
}
