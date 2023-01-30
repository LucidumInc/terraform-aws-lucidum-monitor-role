# terraform-aws-lucidum-monitor-role

Terraform module to create the Lucidum Monitor Role in AWS

## Usage

**Note** the example below uses `ref=main`. It is recommended to pin this module to a specific tag version (i.e. `ref=1.0.0`) to avoid breaking changes. See the [releases page](https://github.com/lucidum/terraform-aws-lucidum-monitor-role/releases) for a list of published versions.

```
module "lucidum_monitor_role" {
  source              = "git::https://github.com/lucidum/terraform-aws-lucidum-monitor-role.git?ref=main"
  role_sts_externalid = "YOUR_EXTERNAL_ID"
}

# this will output the Role ARN
output "lucidum_monitor_role" {
  value = module.lucidum_monitor_role.role_arn
}
```

Replace `YOUR_EXTERNAL_ID` with the External ID in the AWS connection panel in Lucidum


## Setup

The following steps demonstrate how to connect AWS in Lucidum when using this terraform module.

1. Add the code above to your terraform code
2. Replace `main` in `ref=main` with the latest version from the [releases page](https://github.com/lucidum/terraform-aws-lucidum-monitor-role/releases)
3. In your browser, open the Lucidum management console
4. Copy the `Lucidum External ID` from the AWS connection panel in Lucidum and replace `YOUR_EXTERNAL_ID` in the module with the ID you copied
   * Do NOT close the drawer or click the Save button at this point
6. Back in your terminal, run `terraform init` to download/update the module
7. Run `terraform apply` and **IMPORTANT** review the plan output before typing `yes`
8. When the terraform is applied, it will output the Role ARN, copy the ARN
9. Paste the Role name into the Role name field in the AWS Connections drawer in Lucidum
10. Click the `Save & Test Connection` button