variable "assume_role" {
  type        = bool
  default     = true
  description = "Whether to assume the deployer role to provision resources"
}

variable "account_id" {
  type        = string
  description = "The AWS Account ID of the target account"
}

variable "deployer_role_name_template" {
  type        = string
  default     = "%s-%s-%s-%s"
  description = "IAM Role ARN template for the deployer role"
}

variable "deployer_role_environment_name" {
  type        = string
  default     = "gbl"
  description = "The name of the environment for the deployer role"
}

variable "deployer_role_stage_name" {
  type        = string
  default     = "root"
  description = "The name of the environment for the deployer role"
}

variable "deployer_role_name" {
  type        = string
  default     = "terraform-deployer"
  description = "IAM Role name for the deployer"
}

locals {
  deployer_role_arn_template = "arn:aws:iam::%s:role/%s"

  deployer_role_name = format(var.deployer_role_name_template, module.this.namespace, var.deployer_role_environment_name, var.deployer_role_stage_name, var.deployer_role_name)
  deployer_role_arn  = var.assume_role ? format(local.deployer_role_arn_template, var.account_id, local.deployer_role_name) : null
}

provider "aws" {
  assume_role {
    role_arn = local.deployer_role_arn
  }
}

