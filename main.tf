################################ VPC module ###################### 
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = "192.168.0.0/16"
  private_subnet_count = 2
  public_subnet_count  = 2
  tags = {
    Name        = "vipin"
    environment = "training"
    Owner       = "vyadav@presidio.com"
  }
}

## create key from local ssh public key
resource "aws_key_pair" "ssh_key_pair" {
  key_name   = "vipin-ssh-key-tf"
  public_key = file(var.public_key_path)
}

################################### EC2 Module ########################
module "ec2" {
  source                      = "./modules/ec2"
  vpc_id                      = module.vpc.vpc_id
  instance_type               = "t2.micro"
  instance_count              = 4
  associate_public_ip_address = false
  # subnets_ids                 = module.vpc.public_subnet_ids
  subnets_ids                 = module.vpc.private_subnet_ids
  key_name                    = aws_key_pair.ssh_key_pair.key_name
  ami_id                      = data.aws_ami.latest_amazon_linux_ami.id
  private_key_path            = var.private_key_path
  instance_ssh_cidrs          = ["0.0.0.0/0"]
  instance_ingress_ports      = ["80"]

  user_data = <<EOF
                #! /bin/bash
                sudo yum update
                sudo yum install -y httpd mysql
                sudo amazon-linux-extras install -y php7.2 
                sudo systemctl start httpd
                sudo systemctl enable httpd
                sudo echo "<h1>Deployed via Terraform</h1><h2>served by $(hostname)</h2>" > /var/www/html/index.html
                #sudo echo DB_HOST="module.rds.rds_endpoint" >> /etc/environment
                #sudo echo DB_NAME=${var.db_name} >> /etc/environment
                #sudo echo DB_USERNAME=${var.db_username} >> /etc/environment
                #sudo echo DB_PASSWORD=${var.db_password} >> /etc/environment
	            EOF

  tags = {
    Name        = "vipin"
    environment = "training"
    Owner       = "vyadav@presidio.com"
  }
}
################### ALB module ###########################
module "alb" {
  source                = "./modules/alb"
  name                  = "vipin-alb"
  subnets_ids           = module.vpc.public_subnet_ids
  target_group_name     = "vipin-TG-tf"
  vpc_id                = module.vpc.vpc_id
  target_instance_count = module.ec2.instance_count
  target_ids            = module.ec2.instance_ids
  tags = {
    Name        = "vipin"
    environment = "training"
    Owner       = "vyadav@presidio.com"
  }

}

######################### RDS module #######################
/*
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
  allowed_cidrs       = module.vpc.public_subnet_cidrs
  tags = {
    Name        = "vipin"
    environment = "training"
    Owner       = "vyadav@presidio.com"
  }
}
*/
