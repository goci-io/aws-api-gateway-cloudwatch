# aws-api-gateway-settings

**Maintained by [@goci-io/prp-terraform](https://github.com/orgs/goci-io/teams/prp-terraform)**

This module creates a new IAM service role to be used by API Gateway to write logs to CloudWatch and to setup the API Gateway Account. 

```hcl
module "apigw_settings" {
  source     = "git::https://github.com/goci-io/aws-api-gateway-settings.git?ref=tags/<latest-version>"
  namespace  = "goci"
  stage      = "staging"
  region     = "eu1"
  aws_region = "eu-central-1"
}
```

Results in an IAM role named `goci-staging-api-logs-eu1` with region based access to write Logs to CloudWatch.
The role ARN will also be set for API Gateway Settings.

### Configuration

| Name | Description | Default |
|-----------------|----------------------------------------|---------|
| namespace | The company or organization prefix (eg: goci) | - |
| stage | The stage this configuration is for (eg: staging or prod) | - |
| name | Optional name (subdomain) for this hosted zone | `api` |
| attributes | Additional attributes (e.g. `["eu1"]`) | `["logs"]` | 
| tags | Additional tags (e.g. `map("BusinessUnit", "XYZ")` | `{}` | 
| delimiter | Delimiter between namespace, stage, name and attributes | `-` |
| region | Custom region name to use for labels and tags | `var.aws_region` |
| aws_region | AWS Region to apply the account settings to | - |
| aws_assume_role_arn | Role to assume to create resources | "" |
