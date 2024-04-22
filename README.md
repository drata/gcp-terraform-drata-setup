# gcp-terraform-drata-setup

GCP terraform module to create the Drata Read Only service account.

## Example Usage

The example below uses `ref=main` (which is appended in the URL),  but it is recommended to use a specific tag version (i.e. `ref=1.0.0`) to avoid breaking changes. Go to the release page for a list of published versions. [releases page](https://github.com/drata/gcp-terraform-drata-setup/releases) for a list of published versions.

Replace `YOUR_ORGANIZATION_DOMAIN` with the organization domain. i.e. `your_org.com`.
```
module "service_account_creation" {
  source = "git::https://github.com/drata/gcp-terraform-drata-setup.git?ref=main"
  gcp_org_domain = "YOUR_ORGANIZATION_DOMAIN"
  # gcp_project_id = "YOUR_PROJECT_ID" # if it's unset, the project by default is used
  # drata_role_name = "YOUR_ROLE_NAME" # if it's unset, the default name is DrataReadOnly
  # connect_multiple_projects = false # if it's unset, the default value is true
}

output "drata_service_account_key" {
  value = module.service_account_creation.drata_service_account_key
  description = "Service Account Key"
  sensitive = true
}
```

After you apply this terraform, run the following command to retrieve the key file `drata-gcp-private-key.json`
```
terraform output -raw drata_service_account_key > drata-gcp-private-key.json
```

## Setup

The following steps demonstrate how to connect GCP in Drata when using this terraform module.

1. Add the code above to your terraform project.
2. Make sure the service account to authenticate this script has the roles `Organization Administrator`, `Service Account Admin`, `Service Account Key Admin` and ` Service Usage Admin`.
3. Replace `main` in `ref=main` with the latest version from the [releases page](https://github.com/drata/gcp-terraform-drata-setup/releases).
4. Replace `YOUR_ORGANIZATION_DOMAIN` with the GCP organization domain.
5. Replace `YOUR_PROJECT_ID` if the desired project is not the default project in your organization.
6. Replace the given `drata_role_name` if you don't want the role added to be the default: `DrataReadOnly`.
7. If you don't wish to connect multiple projects to Drata the `connect_multiple_projects` variable must be `false` otherwise `true` or unset.
8. Back in your terminal, run `terraform init` to download/update the module.
9. Run `terraform apply` and **IMPORTANT** review the plan output before typing `yes`.
10. If successful, run the command to generate the json key file 
     - `terraform output -raw drata_service_account_key > drata-gcp-private-key.json` .
11. Verify the file has been generated.
12. Go to the GCP connection drawer and select Upload File to upload the `drata-gcp-private-key.json` file.
13. Select the `Save & Test Connection` button.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.16.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_organization_iam_custom_role.drata_org_role](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_member.drata_organization_viewer_role](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.organization](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/organization_iam_member) | resource |
| [google_project_iam_custom_role.drata_project_role](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.drata_member_project_role](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.drata_project_viewer_role](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/project_iam_member) | resource |
| [google_project_service.services](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/project_service) | resource |
| [google_service_account.drata](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/service_account) | resource |
| [google_service_account_key.drata_key](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/service_account_key) | resource |
| [google_organization.gcp_organization](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/data-sources/organization) | data source |
| [google_project.gcp_project](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connect_multiple_projects"></a> [connect\_multiple\_projects](#input\_connect\_multiple\_projects) | Tells the service account whether it can see all the projects or not. | `bool` | `true` | no |
| <a name="input_drata_role_name"></a> [drata\_role\_name](#input\_drata\_role\_name) | Role name. | `string` | `"DrataReadOnly"` | no |
| <a name="input_gcp_org_domain"></a> [gcp\_org\_domain](#input\_gcp\_org\_domain) | GCP Organization domain. | `string` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | Project identifier of the gcp organization. If it is not provided, the provider project is used. | `string` | `null` | no |
| <a name="input_gcp_services"></a> [gcp\_services](#input\_gcp\_services) | List of services to enable. | `list(string)` | <pre>[<br>  "cloudresourcemanager.googleapis.com",<br>  "compute.googleapis.com",<br>  "admin.googleapis.com",<br>  "sqladmin.googleapis.com",<br>  "monitoring.googleapis.com"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_drata_service_account_key"></a> [drata\_service\_account\_key](#output\_drata\_service\_account\_key) | Service Account Key |
<!-- END_TF_DOCS -->
