
variable "stage" {
  type        = string
  description = "The stage the resources will be deployed for"
}

variable "name" {
  type        = string
  default     = "api"
  description = "The name for this API"
}

variable "namespace" {
  type        = string
  description = "Organization or company namespace prefix"
}

variable "attributes" {
  type        = list
  default     = ["logs"]
  description = "Additional attributes (e.g. `eu1`)"
}

variable "tags" {
  type        = map
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "aws_assume_role_arn" {
  type        = string
  default     = ""
  description = "The AWS Role ARN to assume to create resources"
}

variable "aws_region" {
  type        = string
  description = "The AWS region the api gateway settings apply to"
}

variable "region" {
  type        = string
  default     = ""
  description = "Custom region name to use to avoid IAM naming conflicts. Defaults to aws_region"
}
