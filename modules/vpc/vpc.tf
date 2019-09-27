resource "aws_vpc" "custom_vpc" {
  cidr_block            = var.vpc_cidr_block
  instance_tenancy      = "default"
  enable_dns_support    = "${var.vpc_enable_dns_support}"
  enable_dns_hostnames  = "${var.vpc_enable_dns_hostnames}"

  tags = {
    Name = "Custom_VPC"
  }
}


resource "aws_subnet" "public_sn" {
  #use count to loop through a list, length will return the amount of items on the list. Then you can refence count.index for each list item.
  count                   = length(var.public_sn_cidr_block)
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public_sn_cidr_block[count.index]
  map_public_ip_on_launch = var.public_sn_map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "Public_Subnet_${count.index}"
  }
}

resource "aws_subnet" "private_sn" {
  count                   = length(var.private_sn_cidr_block)
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.private_sn_cidr_block[count.index]
  map_public_ip_on_launch = var.private_sn_map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "Private_Subnet_${count.index}"
  }
}

resource "aws_internet_gateway" "i_gw" {
    vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "Internet_GW"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.i_gw.id
  }

  tags = {
    Name = "Public_Subnet_Route"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id  = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.n_gw.id
  }

  tags = {
    Name = "Private_Subnet_Route"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  count           = length(var.public_sn_cidr_block)
  subnet_id       = aws_subnet.public_sn.*.id[count.index]
  route_table_id  = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_assoc" {
  count           = length(var.private_sn_cidr_block)
  subnet_id       = aws_subnet.private_sn.*.id[count.index]
  route_table_id  = aws_route_table.private_rt.id
}

resource "aws_eip" "nat_ip" {
  vpc = true
  depends_on = ["aws_internet_gateway.i_gw"]
}

resource "aws_nat_gateway" "n_gw" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id = aws_subnet.public_sn.0.id
  depends_on = ["aws_internet_gateway.i_gw"]

  tags = {
    Name = "NAT_Gateway"
  }
}
