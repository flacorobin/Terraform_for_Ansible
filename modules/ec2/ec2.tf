resource "aws_instance" "ec2" {
#This creates a new EC2 instance
  count                   = var.ec2_instance_number
  ami											= var.ec2_ami
	instance_type					 	= var.ec2_instance_type
	key_name								= var.ec2_key_name #KeyPair to be used on EC2
	vpc_security_group_ids	=	var.ec2_vpc_security_group_ids #Attach existing SG, value expects a list of SG NAMES []
	subnet_id								=	var.ec2_module_custom_vpc_private_sn_id
	user_data								= var.ec2_user_data #reads Bootscript_Webservers.sh file from current directory and loads it as a bootstrap script

	tags						=	{
			"Name" = "${var.ec2_tags_name}${count.index + 1}"
	}


  	provisioner "local-exec"{
  	command = "echo ${aws_instance.ec2.*.private_ip[count.index]} ${aws_instance.ec2.*.tags.Name[count.index]} >> hosts" #executes command locally, here gets the Public IP of the instance and saves it on a file
  	}
}
