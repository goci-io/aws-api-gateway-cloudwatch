terraform {
  required_version = ">= 0.12.1"
}

provider "aws" {
  version = "~> 2.25"
  region  = var.aws_region

  assume_role {
    role_arn = var.aws_assume_role_arn
  }
}

locals {
  region = var.region == "" ? var.aws_region : var.region
}

module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.15.0"
  namespace  = var.namespace
  stage      = var.stage
  delimiter  = var.delimiter
  name       = var.name
  attributes = var.attributes
  tags       = merge(var.tags, { Region = local.region }
}

module "role_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.15.0"
  context    = module.label.context
  attributes = [local.region]
}

data "aws_iam_policy_document" "trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = [var.aws_region]
    }
  }
}

resource "aws_iam_role" "logging" {
  name               = module.role_label.id
  tags               = module.role_label.tags
  path               = "/service/"
  description        = "Role for APIGateway in ${local.region} to use CloudWatch logs"
  assume_role_policy = data.aws_iam_policy_document.trust.json
}

resource "aws_iam_role_policy_attachment" "allow_cloudwatch" {
  role       = aws_iam_role.logging.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_api_gateway_account" "settings" {
  cloudwatch_role_arn = aws_iam_role.logging.arn
}
