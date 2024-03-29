# get default project
data "google_project" "gcp_project" {
  count = var.gcp_project_id == null ? 1 : 0
}

# get organization data
data "google_organization" "gcp_organization" {
  domain = var.gcp_org_domain
}

# set project id in local variable
locals {
  PROJECT_ID = var.gcp_project_id == null ? data.google_project.gcp_project[0].project_id : var.gcp_project_id
}

# enable services
resource "google_project_service" "services" {
  for_each           = toset(var.gcp_services)
  service            = each.value
  disable_on_destroy = false
  project            = local.PROJECT_ID
}

# create project custom role
resource "google_project_iam_custom_role" "drata_project_role" {
  role_id     = "${var.drata_role_name}ProjectRole"
  title       = "Drata Read-Only Project Role"
  description = "Service Account for Drata Autopilot to get read access to all project resources"
  permissions = ["storage.buckets.get", "storage.buckets.getIamPolicy"]
  project     = local.PROJECT_ID
}

# create organizational role
resource "google_organization_iam_custom_role" "drata_org_role" {
  role_id     = "${var.drata_role_name}OrganizationalRole"
  title       = "Drata Read-Only Organizational Role"
  description = "Service Account with read-only access for Drata Autopilot to get organizational IAM data"
  permissions = ["resourcemanager.organizations.getIamPolicy", "storage.buckets.get", "storage.buckets.getIamPolicy"]
  org_id      = data.google_organization.gcp_organization.org_id
}

# creation of the service account
resource "google_service_account" "drata" {
  account_id   = lower(var.drata_role_name)
  display_name = "dratareadonly"
  project      = local.PROJECT_ID
}

# create json key file
resource "google_service_account_key" "drata_key" {
  service_account_id = google_service_account.drata.id
}

# assignation of roles to the service account
# project role
resource "google_project_iam_member" "drata_member_project_role" {
  project = local.PROJECT_ID
  role    = google_project_iam_custom_role.drata_project_role.name
  member  = "serviceAccount:${google_service_account.drata.email}"
}
# organization role
resource "google_organization_iam_member" "organization" {
  org_id = data.google_organization.gcp_organization.org_id
  role   = google_organization_iam_custom_role.drata_org_role.name
  member = "serviceAccount:${google_service_account.drata.email}"
}
# viewer role
resource "google_project_iam_member" "drata_viewer_role" {
  project = local.PROJECT_ID
  role    = "roles/viewer"
  member  = "serviceAccount:${google_service_account.drata.email}"
}
