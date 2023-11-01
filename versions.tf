terraform {
  required_version = ">= 0.15"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.4.0"
    }
  }
}
