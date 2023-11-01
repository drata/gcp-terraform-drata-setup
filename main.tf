resource "google_project_iam_custom_role" "drata_project_role" {
  role_id     = "DrataReadOnlyProjectRole"
  title       = "Drata Read-Only Project Role"
  description = "Service Account for Drata Autopilot to get read access to all project resources"
  permissions = ["storage.buckets.get", "storage.buckets.getIamPolicy"]
}

resource "google_service_account" "drata" {
  project    = var.project
  account_id = "dratareadonly"
}

resource "google_project_iam_member" "drata_member_project_role" {
  project = var.project
  role    = google_project_iam_custom_role.drata_project_role.name
  member  = "serviceAccount:${google_service_account.drata.email}"
}

resource "google_project_iam_member" "drata_viewer_role" {
  project = var.project
  role    = "roles/viewer"
  member  = "serviceAccount:${google_service_account.drata.email}"
}

resource "google_organization_iam_custom_role" "drata_org_role" {
  role_id     = "DrataReadOnlyOrganizationalRole"
  org_id      = var.org_id
  title       = "Drata Read-Only Organizational Role"
  description = "Service Account with read-only access for Drata Autopilot to get organizational IAM data."
  permissions = ["resourcemanager.organizations.getIamPolicy", "storage.buckets.get", "storage.buckets.getIamPolicy"]
}

resource "google_organization_iam_member" "organization" {
  org_id = var.org_id
  role   = google_organization_iam_custom_role.drata_org_role.name
  member = "serviceAccount:${google_service_account.drata.email}"
}
