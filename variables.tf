variable "account_id" {
  description = "(Required) The AWS Account ID of the target account"
  type        = string
}

variable "role_sts_externalid" {
  description = "(Required) STS ExternalId condition value to use with the role."
  type        = string
}

variable "assume_role" {
  description = "(Optional) Whether to assume the deployer role to provision resources"
  type        = bool
  default     = true
}

variable "prefix" {
  description = "(Optional) The prefix to attach to the role / policy."
  type        = string
  default     = null
}

variable "role_name" {
  description = "(Optional) The role name."
  type        = string
  default     = "lucidum_assume_role"
}

variable "lucidum_account_arn" {
  description = "(Optional) The arn of Lucidum's AWS account."
  type        = string
  default     = "arn:aws:iam::365329389986:root"
}

variable "deployer_role_name" {
  description = "(Optional) IAM Role name for the deployer"
  type        = string
  default     = "OrganizationAccountAccessRole"
}

variable "max_session_duration" {
  description = "(Optional) Maximum session duration (in seconds) for the role"
  type = number
  default = 14400 
}

variable "tags" {
  description = "(Optional) A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}