resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = "infra-${var.environment}-vpc"
  }
}

resource "aws_eip" "elastic_ip" {
  vpc = true
  tags = {
    Name = "infra-${var.environment}-eip",
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, 1)
  availability_zone = "${var.region}a"

  tags = {
    Name = "infra-${var.environment}-public"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, 2)
  availability_zone = "${var.region}b"

  tags = {
    Name = "infra-${var.environment}-private"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.subnet_private.id
  tags = {
    Name = "infra-${var.environment}-nat-gw"
  }
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "infra-${var.environment}-internet-gw"
  }
}

resource "aws_route_table" "internet_gw_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "infra-${var.environment}-internet-gateway-rt"
  }
}

resource "aws_route_table" "nat_gateway_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "infra-${var.environment}-nat-gateway-rt"
  }
}

resource "aws_route_table_association" "rt_public_subnet" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.internet_gw_rt.id
}

resource "aws_route_table_association" "rt_private_subnet" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.nat_gateway_rt.id
}