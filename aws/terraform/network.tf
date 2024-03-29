resource "aws_vpc" "vpc" {
  count                = "${local.vpc_count}"
  cidr_block           = "${var.vpc_cidr}"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags {
    Name = "${var.env_id}-vpc"
  }
}

resource "aws_subnet" "jumpbox_subnet" {
  vpc_id     = "${local.vpc_id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 12, 3200)}"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "${var.env_id}-jumpbox-subnet"
  }
}

resource "aws_route_table" "jumpbox_route_table" {
  vpc_id = "${local.vpc_id}"
}

resource "aws_route" "jumpbox_route_table" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${local.igw_id}"
  route_table_id         = "${aws_route_table.jumpbox_route_table.id}"
}

resource "aws_route_table_association" "route_jumpbox_subnets" {
  subnet_id      = "${aws_subnet.jumpbox_subnet.id}"
  route_table_id = "${aws_route_table.jumpbox_route_table.id}"
}

resource "aws_internet_gateway" "igw" {
  count  = "${local.igw_count}"
  vpc_id = "${local.vpc_id}"
}

locals {
  jumpbox_name        = "jumpbox-${var.env_id}"
  internal_cidr        = "${aws_subnet.jumpbox_subnet.cidr_block}"
  internal_gw          = "${cidrhost(local.internal_cidr, 1)}"
  jumpbox_internal_ip = "${cidrhost(local.internal_cidr, 6)}"
}
