variable "vpc_cidr_block" {
  default = "10.0.0.0/0"
}

variable "vpc_enable_dns_support" {
  type = bool
  default = true
}

variable "vpc_enable_dns_hostnames" {
  type = bool
  default = true
}

variable "public_sn_cidr_block" {
  type = list
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}


variable "public_sn_map_public_ip_on_launch" {
  type = bool
  default = true
}

variable "public_sn_availability_zone" {
  default = "us-east-1a"
}


variable "private_sn_cidr_block" {
  type = list
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_sn_map_public_ip_on_launch" {
    type = bool
  default = true
}

variable "private_sn_availability_zone" {
  default = "us-east-1a"
}

data "aws_availability_zones" "azs" {}
