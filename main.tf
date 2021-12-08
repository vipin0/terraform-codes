# -------------------------------------------------------------#
#                     VPC                                      #
# -------------------------------------------------------------#
resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.tag_prefix}-VPC"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}

# -------------------------------------------------------------#
#                     subnets                                  #
# -------------------------------------------------------------#

resource "aws_subnet" "public_subnets" {
  vpc_id     = aws_vpc.my_vpc.id
  count = length(var.public_subnet_cidrs)
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.tag_prefix}-public-subnet-${count.index}"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id     = aws_vpc.my_vpc.id
  count = length(var.private_subnet_cidrs)
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.tag_prefix}-private-subnet-${count.index}"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}
# -------------------------------------------------------------#
#                    Internet Gateway                          #
# -------------------------------------------------------------#

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${var.tag_prefix}-igw"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}

# -------------------------------------------------------------#
#                    NAT Gateway                               #
# -------------------------------------------------------------#

// aws_eip 
resource "aws_eip" "nat_eip" {
  vpc  = true
}

// nat gateway
resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name = "${var.tag_prefix}-nat"
    Owner = var.owner
    ManagedBy = "Terraform"
  }

  depends_on = [aws_internet_gateway.my_igw]
}
# -------------------------------------------------------------#
#                     route tables                             #
# -------------------------------------------------------------#

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "${var.tag_prefix}-public-rtb"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat.id
  }

  tags = {
    Name = "${var.tag_prefix}-private-rtb"
    Owner = var.owner
    ManagedBy = "Terraform"
  }
}

# -------------------------------------------------------------#
#                     subnet associations                      #
# -------------------------------------------------------------#
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rtb.id
  depends_on = [
    aws_subnet.public_subnets
  ]
}
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rtb.id
  depends_on = [
    aws_subnet.private_subnets
  ]
}




