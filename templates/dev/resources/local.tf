locals {

  name   = var.infra_name
  region = var.infra_region

  apps_vpc_cidr = var.vpc_apps_cidr
  azs           = slice(data.aws_availability_zones.available.names, 0, 3)

  apps_private_subnets     = var.eks_private_subnets
  apps_public_subnets      = var.ingress_public_subnets
  database_private_subnets = var.database_private_subnets

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  environment = var.environment
  project     = var.project

  accepter_account_id = "${data.aws_caller_identity.current.account_id}"
  tags = {
    project     = var.project
    Terraform   = true
    environment = var.environment
   # Blueprint  = local.name
   # GithubRepo = "github.com/aws-ia/terraform-aws-eks-blueprints"
  }
}


