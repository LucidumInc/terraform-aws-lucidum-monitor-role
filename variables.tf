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
  default     = null
}
