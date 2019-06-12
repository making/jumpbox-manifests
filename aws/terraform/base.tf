terraform {
  required_version = "< 0.12.0"
}

locals {
  vpc_count = "${length(var.existing_vpc_id) > 0 ? 0 : 1}"
  vpc_id    = "${length(var.existing_vpc_id) > 0 ? var.existing_vpc_id : join(" ", aws_vpc.vpc.*.id)}"
  igw_count = "${length(var.existing_igw_id) > 0 ? 0 : 1}"
  igw_id    = "${length(var.existing_igw_id) > 0 ? var.existing_igw_id : join(" ", aws_internet_gateway.igw.*.id)}"
}

resource "aws_eip" "jumpbox_eip" {
  depends_on = ["aws_internet_gateway.igw"]
  vpc        = true
}

resource "tls_private_key" "jumpbox_vms" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jumpbox_vms" {
  key_name   = "${var.env_id}_jumpbox_vms"
  public_key = "${tls_private_key.jumpbox_vms.public_key_openssh}"
}
