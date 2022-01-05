# -------------------------------------------------------------#
#                     VPC                                      #
# -------------------------------------------------------------#
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}Vpc"
    }
  )
}

# -------------------------------------------------------------#
#                     subnets                                  #
# -------------------------------------------------------------#

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index % length(var.azs)]
  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}PublicSubnet-${count.index}"
    }
  )
}
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index % length(var.azs)]
  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}PrivateSubnet-${count.index}"
    }
  )
}

# -------------------------------------------------------------#
#                    Internet Gateway                          #
# -------------------------------------------------------------#

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}InternetGateway"
    }
  )
}


# -------------------------------------------------------------#
#                    NAT Gateway                               #
# -------------------------------------------------------------#

// aws_eip 
resource "aws_eip" "nat_eip" {
  count = length(var.azs)
  vpc   = true
  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}eip-${count.index}"
    }
  )
}

// nat gateway
resource "aws_nat_gateway" "my_nat" {
  count         = length(var.azs)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id
  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}Nat-${count.index}"
    }
  )

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

  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}PublicRT"
    }
  )
}
resource "aws_route_table" "private_rtb" {
  count  = length(var.azs)
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat[count.index].id
  }
  tags = merge(
    var.tags,
    {
      "Name" : "${var.tag_prefix}PrivateRT-${count.index}"
    }
  )
}

# -------------------------------------------------------------#
#                     subnet associations                      #
# -------------------------------------------------------------#
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rtb.id
  depends_on = [
    aws_subnet.public_subnets
  ]
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rtb[count.index].id
  depends_on = [
    aws_subnet.private_subnets
  ]
}






