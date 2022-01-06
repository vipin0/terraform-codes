################################ VPC module ###################### 
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  azs                  = ["us-east-2a", "us-east-2b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

  tags = {
    environment = "training"
    Owner       = "vyadav@presidio.com"
  }
  tag_prefix = "vipin/"
}


################################### EC2 Module ########################

module "ec2" {
  source                      = "./modules/ec2"
  vpc_id                      = module.vpc.vpc_id
  instance_type               = "t2.micro"
  min_size                    = 1
  max_size                    = 2
  desired_capacity            = 1
  associate_public_ip_address = false
  subnet_ids                  = module.vpc.private_subnet_ids
  key_name                    = "vipin_ohio"
  ami_id                      = data.aws_ami.latest_amazon_linux_ami.id
  alb_security_group_id       = module.alb.alb_security_group_id
  instance_ssh_cidrs          = ["0.0.0.0/0"]
  instance_ingress_ports      = ["80"]
  alb_target_group_arn        = module.alb.aws_lb_target_group_arn
  user_data                   = <<EOF
                #! /bin/bash
                sudo yum update -y
                sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
                sudo yum install -y httpd mariadb-server git
                sudo systemctl start httpd
                sudo systemctl enable httpd
                # sudo echo "<h1>Deployed by abhishek</h1>" > /var/www/html/index.html
                git clone https://github.com/vipin0/php-db-connection.git /tmp/php
                sudo mv /tmp/php/index.php /var/www/html/
                sudo systemctl restart httpd
                EOF

  tags = {
    environment = "training"
    Owner       = "vyadav@presidio.com"
  }
  tag_prefix = "vipin/"
}

################### ALB module ###########################
module "alb" {
  source            = "./modules/alb"
  name              = "vipin-alb"
  subnets_ids       = module.vpc.public_subnet_ids
  target_group_name = "vipin-TG-tf"
  vpc_id            = module.vpc.vpc_id
  tags = {
    environment = "training"
    Owner       = "vyadav@presidio.com"
  }
  tag_prefix = "vipin/"
}

######################### RDS module #######################

module "rds" {
  source              = "./modules/rds"
  subnet_group_name   = "vipin-rds"
  subnet_ids          = module.vpc.private_subnet_ids
  identifier          = "vipin-rds"
  db_instance_class   = "db.t3.micro"
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  security_group_name = "vipin-rds-sg"
  vpc_id              = module.vpc.vpc_id

  allowed_cidrs = module.vpc.private_subnet_cidrs
  tags = {
    environment = "training"
    Owner       = "vyadav@presidio.com"
  }
  tag_prefix = "vipin/"
}

