include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

inputs = {
  name                 = "terragrunt-hands-on-qa"
  vpc_cidr             = "10.41.0.0/16"
  availability_zones   = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs  = ["10.41.0.0/20", "10.41.16.0/20"]
  private_subnet_cidrs = ["10.41.32.0/20", "10.41.48.0/20"]

  enable_nat_gateway              = false
  nat_gateway_mode                = "per_az"
  enable_s3_endpoint              = false
  enable_ecr_endpoints            = false
  enable_cloudwatch_logs_endpoint = false
  enable_sts_endpoint             = false
  endpoint_allowed_cidrs          = ["10.41.32.0/20", "10.41.48.0/20"]

  tags = {
    Component = "networking"
    Project   = "terragrunt-hands-on"
  }
}