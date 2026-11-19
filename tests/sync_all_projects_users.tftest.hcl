mock_provider "google" {
  mock_data "google_organization" {
    defaults = {
      org_id = "123456789"
    }
  }
}

variables {
  gcp_org_domain = "example.com"
  gcp_project_id = "proj-1"
}

run "default_does_not_grant_project_iam_read" {
  command = plan

  assert {
    condition     = !contains(google_organization_iam_custom_role.drata_org_role.permissions, "resourcemanager.projects.getIamPolicy")
    error_message = "The organization role must not read project IAM policies by default."
  }

  assert {
    condition     = length(google_organization_iam_custom_role.drata_org_role.permissions) == 6
    error_message = "The organization role must keep exactly its 6 default permissions."
  }
}

run "opt_in_grants_project_iam_read" {
  command = plan

  variables {
    sync_all_projects_users = true
  }

  assert {
    condition = alltrue([
      for permission in ["resourcemanager.projects.get", "resourcemanager.projects.list", "resourcemanager.projects.getIamPolicy"] :
      contains(google_organization_iam_custom_role.drata_org_role.permissions, permission)
    ])
    error_message = "The organization role must include the 3 project IAM read permissions."
  }

  assert {
    condition     = output.sync_all_projects_users == true
    error_message = "The sync_all_projects_users output must be true."
  }
}

run "opt_in_without_multiple_projects" {
  command = plan

  variables {
    sync_all_projects_users   = true
    connect_multiple_projects = false
  }

  assert {
    condition = alltrue([
      for permission in ["resourcemanager.projects.get", "resourcemanager.projects.list", "resourcemanager.projects.getIamPolicy"] :
      contains(google_organization_iam_custom_role.drata_org_role.permissions, permission)
    ])
    error_message = "The project IAM read permissions must not depend on connect_multiple_projects."
  }

  assert {
    condition     = length(google_organization_iam_member.drata_organization_viewer_role) == 0
    error_message = "The organization viewer role must not be granted when connect_multiple_projects is false."
  }
}
