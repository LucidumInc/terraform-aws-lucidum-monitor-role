# terraform-aws-lucidum-monitor-role

Terraform module to create the Lucidum monitor role in AWS

## Usage

**Note** the example below uses `ref=main`. It is recommended to pin this module to a specific tag version (i.e. `ref=1.0.0`) to avoid breaking changes. See the [releases page](https://github.com/LucidumInc/terraform-aws-lucidum-monitor-role/releases) for a list of published versions.

```
module "lucidum_monitor_role" {
  source              = "git::https://github.com/LucidumInc/terraform-aws-lucidum-monitor-role.git?ref=main"
  
  assume_role         = true
  account_id          = "TARGET_AWS_ACCOUNT_ID"
  role_sts_externalid = "lucidum-access"
}

# this will output the Role ARN
output "lucidum_monitor_role" {
  value       = module.lucidum_monitor_role.iam_role
}
```


## Setup

The following steps demonstrate how to connect AWS in Lucidum when using this terraform module.


### Setup For The Current AWS Account

1. Add the code above to your terraform code
2. Replace `main` in `ref=main` with the latest version from the [releases page](https://github.com/LucidumInc/terraform-aws-lucidum-monitor-role/releases)
3. Set the `assume_role` to `false`
4. Replace the `TARGET_AWS_ACCOUNT_ID` with your AWS account ID.
5. Replace the `role_sts_externalid` with your external ID. **IMPORTANT** If you have multiple AWS accounts, the same external ID has to be used for all accounts. It is recommanded to generate a random unique string for the external ID. By default, it is `lucidum-access`
6. Login to your AWS account in terminal. Ex. `aws login` or `aws sso login`
7. Run `terraform init` to download/update the module
8. Run `terraform apply` and **IMPORTANT** review the plan output before typing `yes`
9. When the terraform is applied, it will output the Role ARN.
10. Login to your Lucidum server and click **Connector** in the left panel.
11. On the Connector page, click **Add Connector**
12. Scroll until you find the connector for AWS. Click **Connect**. The settings page appears.
13. Enter the **Role name**. By default, it is `lucidum_assume_role`. You can change it in your terraform codes by passing in the `role_name` variable.
14. Enter the **External role ID**, which is the variable `role_sts_externalid` in your terraform codes.
15. Enter the **Role duration**. By default, it is 4 hours (14400 seconds). You can change it in your terraform codes by passing in the `max_session_duration` variable.
16. Add the account ID for each AWS account that will allow Lucidum to use the role to ingest data. Click the **Add Row** button to add more AWS account IDs as needed if the same role has been set up in multiple AWS accounts
17. To test the configuration, click **Test**
  * If the connector is configured correctly, Lucidum displays a list of services that are accessible with the connector.
  * If the connector is not configured correctly, Lucidum displays an error message.
18. Click the **Save** button.


### Setup For Member Accounts In Your AWS Organization Unit

If you have AWS Organization set up, you can manage your member accounts from your management account. AWS Organizations automatically creates an IAM role that is by default named `OrganizationAccountAccessRole`. 

1. Add the code above to your terraform code
2. Replace `main` in `ref=main` with the latest version from the [releases page](https://github.com/LucidumInc/terraform-aws-lucidum-monitor-role/releases)
3. Set the `assume_role` to `true`
4. Replace the `TARGET_AWS_ACCOUNT_ID` with your AWS member account ID.
5. Replace the `role_sts_externalid` with your external ID. **IMPORTANT** If you have multiple AWS accounts, the same external ID has to be used for all accounts. It is recommanded to generate a random unique string for the external ID. By default, it is `lucidum-access`
6. Login to your AWS management account in terminal. Ex. `aws sso login --profile root`
7. Run `aws2-wrap --profile root terraform init` to download/update the module. The aws2-wrap (https://github.com/linaro-its/aws2-wrap) is used in this command. You can also use your favorite tool, like `aws-vault`
8. Run `aws2-wrap --profile root terraform apply` and **IMPORTANT** review the plan output before typing `yes`
9. When the terraform is applied, it will output the Role ARN.
10. Login to your Lucidum server and click **Connector** in the left panel.
11. On the Connector page, click **Add Connector**
12. Scroll until you find the connector for AWS. Click **Connect**. The settings page appears.
13. Enter the **Role name**. By default, it is `lucidum_assume_role`. You can change it in your terraform codes by passing in the `role_name` variable.
14. Enter the **External role ID**, which is the variable `role_sts_externalid` in your terraform codes.
15. Enter the **Role duration**. By default, it is 4 hours (14400 seconds). You can change it in your terraform codes by passing in the `max_session_duration` variable.
16. Add the account ID for each AWS account that will allow Lucidum to use the role to ingest data. Click the **Add Row** button to add more AWS account IDs as needed if the same role has been set up in multiple AWS accounts
17. To test the configuration, click **Test**
  * If the connector is configured correctly, Lucidum displays a list of services that are accessible with the connector.
  * If the connector is not configured correctly, Lucidum displays an error message.
18. Click the **Save** button.

This terraform module helps to set up one AWS account. We also have a python program which helps to list all accounts in the OU and run terraform commands for them. It is available here.
https://github.com/LucidumInc/python-aws-terraform-apply-to-accounts-in-ou

## Parameters

| name | description | default value |
|------|:------------|:-------------:|
| account_id  | (Required)  The AWS Account ID of the target account                  |      |
| assume_role | (Optional) Whether to assume the deployer role to provision resources | `true` |
| prefix  | (Optional) The prefix to attach to the role / policy                 |  `null`  |
| role_name  | (Optional) The role name                 |  `lucidum_assume_role`  |
| lucidum_account_arn  | (Optional) The arn of Lucidum's AWS account |`arn:aws:iam::365329389986:root`|
| role_sts_externalid  | (Optional) STS ExternalId condition value to use with the role |  `null`  |
| deployer_role_name   | (Optional) IAM Role name for the deployer|`OrganizationAccountAccessRole`|
| max_session_duration | (Optional) Maximum session duration (in seconds) for the role. Minimum 4 hours | `14400` |
| tags  | (Optional) A map of tags to add to IAM role resources|`{}`|


