terraform {
  required_version = ">= 0.13.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=5.16.0, <7.0.0"
    }
  }
}
