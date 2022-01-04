# -------------------------------------------------------------#
#                     VPC                                      #
# -------------------------------------------------------------#
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = var.tags
}
# -------------------------------------------------------------#
#                     subnets                                  #
# -------------------------------------------------------------#

############# querying azs ###################
data "aws_availability_zones" "azs" {
  state = "available"
}

## calculating subnets from vpc cidr #############

locals {
  azs        = data.aws_availability_zones.azs.names
  azs_count  = length(local.azs)
  cidr_start = split(".", var.vpc_cidr)
  network_id = join(".", [local.cidr_start[0], local.cidr_start[1]])
  subnets = [
    for i in range(var.public_subnet_count + var.private_subnet_count) :
    {
      cidr_block = "${local.network_id}.${i + 1}.0/24",
      az         = local.azs[i % local.azs_count]
    }
  ]
}

resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.my_vpc.id
  count  = var.public_subnet_count
  # cidr_block        = local.subnets[count.index].cidr_block
  cidr_block = cidrsubnet(var.vpc_cidr, var.newbits, count.index)
  # availability_zone = local.subnets[count.index].az
  availability_zone = data.aws_availability_zones.azs.names[count.index % length(data.aws_availability_zones.azs.names)]
  tags              = var.tags
}

resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.my_vpc.id
  count  = var.private_subnet_count
  # cidr_block        = local.subnets[count.index + var.public_subnet_count].cidr_block
  cidr_block = cidrsubnet(var.vpc_cidr, var.newbits, count.index + var.public_subnet_count)
  # availability_zone = local.subnets[count.index + var.public_subnet_count].az
  availability_zone = data.aws_availability_zones.azs.names[count.index % length(data.aws_availability_zones.azs.names)]
  tags              = var.tags
}

# -------------------------------------------------------------#
#                    Internet Gateway                          #
# -------------------------------------------------------------#

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags   = var.tags
}


# -------------------------------------------------------------#
#                    NAT Gateway                               #
# -------------------------------------------------------------#

// aws_eip 
resource "aws_eip" "nat_eip" {
  vpc = true
}

// nat gateway
resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags          = var.tags

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

  tags = var.tags
}
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat.id
  }
  tags = var.tags
}

# -------------------------------------------------------------#
#                     subnet associations                      #
# -------------------------------------------------------------#
resource "aws_route_table_association" "public" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rtb.id
  depends_on = [
    aws_subnet.public_subnets
  ]
}

resource "aws_route_table_association" "private" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rtb.id
  depends_on = [
    aws_subnet.private_subnets
  ]
}






