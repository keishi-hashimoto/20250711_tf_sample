variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr_block" {
  type    = string
  default = "10.0.0.0/24"
}

variable "private_subnect_az" {
  type    = string
  default = "us-west-2a"
}

variable "public_subnet_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_az" {
  type    = string
  default = "us-west-2b"
}

variable "src_ipaddr" {
  type    = string
  default = "118.238.222.6"
}

variable "public_ec2_num" {
  type    = number
  default = 2
}
