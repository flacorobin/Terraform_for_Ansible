provider "aws" {
#Credentials of access key for accessing AWS account. These are for the user "flac_work_pc"

#Credentials saved on variables in the variables.tf file. NEVER SHARE the varaibles.tf FILE!!
	access_key 	= var.access_key
	secret_key 	= var.secret_key
	region 			= var.region
	version			= "~> 2.10"
}


#This creates a new EC2 instance that will be used as a Reverse Proxy
module "webserver" {
source 															=	"../../modules/ec2/"
ec2_ami															=	data.aws_ami.RHEL8.id //data.aws_ami looks for latest ami on AWS. Defined on varaibles.tf
ec2_instance_number									= 1
ec2_instance_type										= "t2.micro"
ec2_key_name												= var.key_pairs[var.region] #KeyPair to be used on EC2
#ec2_vpc_security_group_ids					=	[module.webserver_sg.id] #Attach existing SG, value expects a list of SG NAMES []
#ec2_module_custom_vpc_private_sn_id	=	module.custom_vpc.public_sn_id[0]
#ec2_user_data												= "${file("./bootscripts/boot-update.sh")}" #reads Bootscript_Webservers.sh file from current directory and loads it as a bootstrap script
ec2_tags_name 											= "WebServer_RP"

}
