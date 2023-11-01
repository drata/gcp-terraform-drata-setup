# Terraform Google Cloud IAM Module

This Terraform module allows you to manage Google Cloud IAM roles and service accounts within a Google Cloud project and organization. It provides an easy way to create custom roles, service accounts, and manage IAM bindings.

## Usage

To use this module in your Terraform configuration, follow these steps:

### Clone the Repository:

Clone the repository to your local machine or reference it remotely if it's hosted elsewhere:

```
git clone https://github.com/drata/terraform-gcp-drata-autopilot-role
```

### Initialize Terraform:

Navigate to the directory containing your Terraform configuration and initialize Terraform:

```
terraform init
```

### Include the Module:

In your Terraform configuration, include the module by specifying the source path. Replace <module_path> with the actual path to the module:

```hcl
module "drata_module" {
  source  = "./path/to/module" # Update with the actual path
  project = "your_project_id"
  org_id  = "your_organization_id"
  region  = "us-central1" # Optional: Specify the desired region
}
```

### Apply the Configuration:

Apply your Terraform configuration to create the IAM roles, service accounts, and bindings:

```
terraform apply
```

### Access Outputs (Optional):

If you need to access the outputs from the module, you can do so in your Terraform configuration:

```hcl
output "drata_service_account_email" {
  value = module.drata_module.service_account_email
}
```

Then, run `terraform output` to see the output values.

### Destroy Resources (Optional):

If you want to destroy the resources created by the module, use the following command:

```
terraform destroy
```

## Variables

* `project`: The Google Cloud project ID where resources will be created.
* `org_id`: The Google Cloud organization ID.
* `region` (optional): The Google Cloud region where resources will be created. Default value is `"us-central1"`.

## Outputs
* `service_account_email`: The email address of the created service account.

## Contributing
Feel free to contribute to this module by submitting issues or pull requests. We welcome any improvements or suggestions.
