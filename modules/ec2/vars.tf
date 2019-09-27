variable "ec2_ami" {

}


variable "ec2_instance_number"{
  default = 1
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "ec2_key_name" {
  default = "MyEC2KeyPair"
}

variable "ec2_vpc_security_group_ids" {
  type = list
  default = []
}

variable "ec2_module_custom_vpc_private_sn_id" {
  default = ""
}

variable "ec2_user_data" {
  default = ""
}

variable "ec2_tags_name" {}
