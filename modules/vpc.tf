resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.private_subnect_az
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.public_subnet_az
  map_public_ip_on_launch = true
}

resource "aws_security_group" "private" {
  vpc_id = aws_vpc.main.id
  name   = "private"
}

resource "aws_security_group" "public" {
  vpc_id = aws_vpc.main.id
  name   = "public"
}

locals {
  ssh_src_cidr = "${var.src_ipaddr}/32"
}

resource "aws_security_group_rule" "public_ingress_ssh" {
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = [local.ssh_src_cidr]
  security_group_id = aws_security_group.public.id
  type              = "ingress"
}

resource "aws_security_group_rule" "public_egress_any" {
  protocol          = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
  type              = "egress"
}

resource "aws_security_group_rule" "private_ingress_from_public_subnet" {
  protocol          = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_blocks       = [var.public_subnet_cidr_block]
  security_group_id = aws_security_group.public.id
  type              = "ingress"
}

resource "aws_security_group_rule" "private_egress_to_public_subnet" {
  protocol          = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_blocks       = [var.public_subnet_cidr_block]
  security_group_id = aws_security_group.private.id
  type              = "egress"
}
