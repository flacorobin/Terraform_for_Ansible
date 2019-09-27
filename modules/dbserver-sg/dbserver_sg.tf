resource "aws_security_group" "dbserver_sg" {
  name        = "dbserver_sg"
  description = "Allow MySQL/Aurora and SSH inbound traffic"
  vpc_id      = var.dbserver_sg_vpc_id

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"] # add your IP address here
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = var.dbserver_sg_ssh_ip
  }

	#	By default, AWS creates an ALLOW ALL egress rule when creating a new Security Group inside of a VPC. When creating a new Security Group inside a VPC, Terraform will remove this default rule, and require you specifically re-create it if you desire that rule
	egress {
		from_port       = 0
		to_port         = 0
		protocol        = "-1"
		cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dbserver_sg"
  }
}
