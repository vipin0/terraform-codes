data "aws_ami" "latest_amazon_linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# data "aws_vpc" "vpc" {
#   filter {
#     name = "tag:enviroment"
#     values = ["training"]
#   }
# }

# data "aws_subnets" "subets" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.vpc.id]
#   }
#   filter {
#     name = "tag:environment"
#     values = ["training"]
#   }
# }


































# data "aws_subnet_ids" "public_subnets" {
#   vpc_id = module.vpc.vpc_id
#   filter {
#     name = "tag:Name"
#     values = ["*public-subnet*"]
#   }
#   depends_on = [
#     aws_subnet.public_subnets
#   ]
# }
# data "aws_subnet_ids" "private_subnets" {
#   vpc_id = module.vpc.vpc_id
#   filter {
#     name = "tag:Name"
#     values = ["*private-subnet*"]
#   }
#   depends_on = [
#     aws_subnet.private_subnets
#   ]
# }

# data "aws_subnet" "public_subnets" {
#   count = length(data.aws_subnet_ids.public_subnets.ids)
#   id = data.aws_subnet_ids.public_subnets.ids[count.index]
#   depends_on = [
#     data.aws_subnet_ids.public_subnets,
#     aws_vpc.my_vpc
#   ]
# }

