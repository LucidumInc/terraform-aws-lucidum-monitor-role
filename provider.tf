locals {
  deployer_role_arn_template  = "arn:aws:iam::%s:role/%s"

  deployer_role_arn           = var.assume_role ? format(local.deployer_role_arn_template, var.account_id, var.deployer_role_name) : null
}

provider "aws" {
  assume_role {
    role_arn                  = local.deployer_role_arn
  }
}

