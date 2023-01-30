locals {
  prefix = var.prefix != null ? "${trimsuffix(var.prefix,"-")}-" : ""
  name   = "${local.prefix}${var.role_name}"
}

data "aws_iam_policy_document" "assume_role" {
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
  name               = local.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = var.tags
}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "AllowLucidumMonitoring"
    effect = "Allow"
    actions = [
                "cloudtrail:Describe*",
                "cloudtrail:Get*",
                "cloudtrail:List*",
                "cloudtrail:LookupEvents",
                "cloudwatch:Describe*",
                "cloudwatch:Get*",
                "cloudwatch:List*",
                "codecommit:List*",
                "codecommit:Get*",
                "config:Describe*",
                "config:Get*",
                "config:List*",
                "dynamodb:Describe*",
                "dynamodb:List*",
                "dynamodb:Scan",
                "ec2:Describe*",
                "ec2:Get*",
                "ecr:Batch*",
                "ecr:Describe*",
                "ecr:Get*",
                "ecr:List*",
                "ecs:Describe*",
                "ecs:List*",
                "eks:Describe*",
                "eks:List*",
                "elasticache:Describe*",
                "elasticloadbalancing:Describe*",
                "guardduty:Get*",
                "guardduty:List*",
                "iam:Get*",
                "iam:List*",
                "inspector:Describe*",
                "inspector:Get*",
                "inspector:List*",
                "kms:Describe*",
                "kms:Get*",
                "kms:List*",
                "lambda:Get*",
                "lambda:List*",
                "logs:PutLogEvents",
                "logs:CreateLogStream",
                "logs:CreateLogGroup",
                "logs:Describe*",
                "logs:FilterLogEvents",
                "logs:Get*",
                "logs:List*",
                "organizations:Describe*",
                "organizations:List*",
                "pricing:Describe*",
                "pricing:Get*",
                "route53:List*",
                "s3:Get*",
                "s3:List*",
                "securityhub:Describe*",
                "securityhub:Get*",
                "securityhub:List*",
                "sns:List*",
                "ssm:Describe*",
                "ssm:Get*",
                "sts:Get*",
                "sts:AssumeRole",
                "tag:Get*",
                "workspaces:Describe*"
    ]
    resources = [
      "*"
    ]
  }
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
