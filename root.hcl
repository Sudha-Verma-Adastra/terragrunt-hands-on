locals {
  module_source = "git::https://github.com/Sudha-Verma-Adastra/terraform-aws-platform-modules.git//modules/vpc?ref=v1.2.0"

  env_config = read_terragrunt_config(
    find_in_parent_folders("env.hcl")
  )

  environment = local.env_config.locals.environment
  aws_region  = local.env_config.locals.aws_region

  workspace = "terragrunt-hands-on-${local.environment}-vpc"
}

terraform {
  source = local.module_source
}

# HCP Terraform remote state and remote execution.
generate "hcp_cloud" {
  path      = "cloud.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<-EOF
terraform {
  cloud {
    organization = "sudha-adastra"

    workspaces {
      name = "${local.workspace}"
    }
  }
}
EOF
}

# Shared AWS provider configuration.
generate "aws_provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<-EOF
provider "aws" {
  region = "${local.aws_region}"

  default_tags {
    tags = {
      Project     = "terragrunt-hands-on"
      Environment = "${local.environment}"
      ManagedBy   = "Terragrunt"
      Component   = "networking"
    }
  }
}
EOF
}