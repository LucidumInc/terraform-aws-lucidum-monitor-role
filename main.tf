locals {
  prefix = var.prefix != null ? "${trimsuffix(var.prefix,"-")}-" : ""
  name   = "${local.prefix}${var.role_name}"
}

data "http" "this" {
  url = "https://raw.githubusercontent.com/LucidumInc/lucidum-deployment-x-account/master/x_account_deployment/lucidum_assume_role_policy.json"

  request_headers = {
    Accept = "application/json"
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.lucidum_account_arn]
    }

    dynamic "condition" {
      for_each = var.role_sts_externalid != null ? [true] : []
      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = [var.role_sts_externalid]
      }
    }
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name                  = local.name
  assume_role_policy    = tostring(data.http.this.response_body)
  max_session_duration  = var.max_session_duration

  tags = var.tags
}

resource "aws_iam_policy" "this" {
  name   = local.name
  policy = data.aws_iam_policy_document.this.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}
