#Terraform uses thos file to DEFINE variables. Use this file in conjuction with terraform.tvars

variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "us-east-1"
}

variable "amis"{
  type = "map"
#Commented the below block because assignment has been move to terraform.tfvars
  default = {
    "us-east-1" = "ami-0cc96feef8c6bbff3"
  }
}

variable "key_pairs"{
  type = "map"
#Commented the below block because assignment has been move to terraform.tfvars
  default = {
    "us-east-1"   = "MyEC2KeyPair"
    "us-east-2"   = "EC2KeyPair-UsEast2"
    "eu-west-1"   = "EC2KeyPair-EuWest1"
  }
}


data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
    }

    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

data "aws_ami" "amazon-linux-2" {
      most_recent = true
      owners      = ["amazon"]

      filter {
  	    name   = "owner-alias"
  	    values = ["amazon"]
      }

      filter {
  	    name   = "name"
  	    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
      }

      filter {
  	    name = "state"
  	    values = ["available"]
      }
}

data "aws_ami" "RHEL8" {
      most_recent = true
      owners      = ["309956199498"]

      filter {
        name   = "name"
        values = ["RHEL-8.0.0_HVM-20190618-x86_64-1-Hourly2-GP2"]
      }

      filter {
  	    name = "state"
  	    values = ["available"]
      }
}
