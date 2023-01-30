variable "assume_role" {
  description = "(Optional) Whether to assume the deployer role to provision resources"
  type        = bool
  default     = true
}

variable "account_id" {
  description = "(Required) The AWS Account ID of the target account"
  type        = string
}

variable "prefix" {
  description = "(Optional) The prefix to attach to the role / policy."
  type        = string
  default     = null
}

variable "role_name" {
  description = "(Optional) The role name."
  type        = string
  default     = "LucidumMonitor" 
  
}

variable "lucidum_account_arn" {
  description = "(Optional) The arn of Lucidum's AWS account."
  type        = string
  default     = "arn:aws:iam::365329389986:root"
}

variable "role_sts_externalid" {
  description = "(Optional) STS ExternalId condition value to use with the role."
  type        = string
  default     = "lucidum-access"
}

variable "deployer_role_name" {
  description = "(Optional) IAM Role name for the deployer"
  type        = string
  default     = "OrganizationAccountAccessRole"
}
