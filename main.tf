provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

# 1. Network: VPC, subnets, internet gateway, route table
module "network" {
  source = "./modules/network"

  vpc_name         = var.vpc_name
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  igw_name         = var.igw_name
  route_table_name = var.route_table_name
  tags             = local.common_tags
}

# 2. Network security: security groups (needs the VPC ID from the network module)
module "network_security" {
  source = "./modules/network_security"

  vpc_id                           = module.network.vpc_id
  allowed_ip_range                 = var.allowed_ip_range
  ssh_security_group_name          = var.ssh_security_group_name
  public_http_security_group_name  = var.public_http_security_group_name
  private_http_security_group_name = var.private_http_security_group_name
  tags                             = local.common_tags
}

# 3. Application: launch template, ASG, load balancer (needs outputs of both modules above)
module "application" {
  source = "./modules/application"

  vpc_id                      = module.network.vpc_id
  subnet_ids                  = module.network.public_subnet_ids
  instance_security_group_ids = [module.network_security.ssh_security_group_id, module.network_security.private_http_security_group_id]
  lb_security_group_id        = module.network_security.public_http_security_group_id
  launch_template_name        = var.launch_template_name
  asg_name                    = var.asg_name
  load_balancer_name          = var.load_balancer_name
  target_group_name           = var.target_group_name
  instance_type               = var.instance_type
  ami_filter                  = var.ami_filter
  desired_capacity            = var.desired_capacity
  min_size                    = var.min_size
  max_size                    = var.max_size
  tags                        = local.common_tags
}
