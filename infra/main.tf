provider "aws" {
  region = var.avail_zone
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["${var.avail_zone}a", "${var.avail_zone}b"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  tags = {
    Name        = "${var.env_prefix}_fargate_vpc"
    Environment = var.env_prefix
  }
}

module "prefect_ecs_agent" {
  source = "github.com/PrefectHQ/prefect-recipes//devops/infrastructure-as-code/aws/tf-prefect2-ecs-agent"

  agent_subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  name                 = "${var.env_prefix}_prefect_agent_demo1"
  prefect_account_id   = var.prefect_account_id
  prefect_api_key      = var.prefect_api_key
  prefect_workspace_id = var.prefect_workspace_id
  vpc_id               = module.vpc.vpc_id
}