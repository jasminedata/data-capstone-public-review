# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    { Name = "${var.name_prefix}-VPC" }
  )
}

# Internet Gateway (IGW)
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.common_tags,
    { Name = "${var.name_prefix}-IGW" }
  )
}

# Public Subnets (AZ1, AZ2)
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    { Name = "${var.name_prefix}-PublicSubnet-${count.index + 1}" }
  )
}

# Private Subnets (AZ1, AZ2)
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.common_tags,
    { Name = "${var.name_prefix}-PrivateSubnet-${count.index + 1}" }
  )
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(
    var.common_tags,
    { Name = "${var.name_prefix}-NAT-EIP" }
  )
}

# NAT Gateway (Required: deployed in AZ2 public subnet; index [1])
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[1].id

  tags = merge(
    var.common_tags,
    { Name = "${var.name_prefix}-NAT-Gateway" }
  )
}

# Public Route Table -> IGW route
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    var.common_tags,
    { Name = "${var.name_prefix}-PublicRT" }
  )
}

# Private Route Table -> NAT route
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = merge(
    var.common_tags,
    { Name = "${var.name_prefix}-PrivateRT" }
  )
}

# Route Table Associations
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Resource: aws_route_table_association.private.
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
