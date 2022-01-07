################################ VPC module ###################### 
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  tag_prefix = var.tag_prefix
  tags = var.additonal_tags
}


################################### EC2 Module ########################

module "ec2" {
  source                      = "./modules/ec2"
  vpc_id                      = module.vpc.vpc_id
  instance_type               = var.instance_type
  min_size                    = var.min_size
  max_size                    = var.max_size
  desired_capacity            = var.desired_capacity
  associate_public_ip_address = var.associate_public_ip_address
  subnet_ids                  = module.vpc.private_subnet_ids
  key_name                    = var.key_name
  ami_id                      = data.aws_ami.latest_amazon_linux_ami.id
  alb_security_group_id       = module.alb.alb_security_group_id
  instance_ssh_cidrs          = var.instance_ssh_cidrs
  instance_ingress_ports      = var.instance_ingress_ports
  alb_target_group_arn        = module.alb.aws_lb_target_group_arn
  user_data                   = var.user_data

  tag_prefix = var.tag_prefix
  tags = var.additonal_tags
}

################### ALB module ###########################
module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  name              = var.name
  subnets_ids       = module.vpc.public_subnet_ids
  target_group_name = var.target_group_name
  
  tag_prefix = var.tag_prefix
  tags = var.additonal_tags
}

######################### RDS module #######################

module "rds" {
  source              = "./modules/rds"
  subnet_group_name   = var.subnet_group_name
  subnet_ids          = module.vpc.private_subnet_ids
  allowed_cidrs = module.vpc.private_subnet_cidrs
  identifier          = var.identifier
  db_instance_class   = var.db_instance_class
  security_group_name = var.security_group_name
  vpc_id              = module.vpc.vpc_id
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  
  tag_prefix = var.tag_prefix
  tags = var.additonal_tags
}

