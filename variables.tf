variable "project" {
  description = "The Google Cloud project ID where resources will be created."
  type        = string
}

variable "org_id" {
  description = "The Google Cloud organization ID."
  type        = string
}

variable "region" {
  description = "The Google Cloud region where resources will be created."
  type        = string
  default     = "us-central1"
}
