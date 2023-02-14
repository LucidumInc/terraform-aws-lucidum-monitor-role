locals {
  prefix                = var.prefix != null ? "${trimsuffix(var.prefix,"-")}-" : ""
  name                  = "${local.prefix}${var.role_name}"
}

data "http" "lucidum_monitor_role" {
  url = "https://raw.githubusercontent.com/LucidumInc/lucidum-deployment-x-account/master/x_account_deployment/lucidum_assume_role_policy.json"

  request_headers = {
    Accept              = "application/json"
  }
}

data "aws_iam_policy_document" "lucidum_monitor_role" {
  statement {
    principals {
      type              = "AWS"
      identifiers       = [var.lucidum_account_arn]
    }

    dynamic "condition" {
      for_each = var.role_sts_externalid != null ? [true] : []
      content {
        test            = "StringEquals"
        variable        = "sts:ExternalId"
        values          = [var.role_sts_externalid]
      }
    }
    effect              = "Allow"
    actions             = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lucidum_monitor_role" {
  name                  = local.name
  assume_role_policy    = data.aws_iam_policy_document.lucidum_monitor_role.json
  max_session_duration  = var.max_session_duration

  tags                  = var.tags
}

resource "aws_iam_role_policy" "lucidum_monitor_role" {
  name                  = local.name
  role                  = aws_iam_role.lucidum_monitor_role.name
  policy                = tostring(data.http.lucidum_monitor_role.response_body)
}
