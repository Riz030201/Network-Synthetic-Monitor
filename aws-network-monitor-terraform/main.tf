module "vpc" {
  source = "./modules/vpc"
  # Add any required input variables here
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  # Add any required input variables here
}

module "iam_role" {
  source = "./modules/iam_role"
  # Add any required input variables here
}

module "nat_gateway" {
  source = "./modules/nat_gateway"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  # Add any required input variables here
}

module "network_monitor" {
  source            = "./modules/network_monitor"
  private_subnet_id = module.vpc.private_subnet_id
  security_group_id = module.security_group.security_group_id
  iam_role_arn      = module.iam_role.iam_role_arn
  laptop_ip         = var.laptop_ip
  vpc_id            = module.vpc.vpc_id
}