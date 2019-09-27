Small Terraform Project with 2 tier custom VPC

- Creates a custom VPC with 2 public subnets and 1 private subnet (192.168.0.0/16)
- Creates Webserver security group for servers exposed to the Internet
- Creates DBserver security group for a database

- Initiates a WebServer that is going to act as a Reverse Proxy
- Initiates a AppServer that will host a small webpage.
- Initiates a Ansible server that will be the Ansible Control Machine, terraform will install ansible and download code from https://github.com/flacorobin/Ansible.

* Designed with re-usable modules

IMPORTANT:
There are a few manual tasks that I will automate on later versions. They consist on the following:
- The Ansible Machine needs to have on its host file the IP addresses of the WebServer and the AppServer. Ansible is expecting this to be able to work.
- Ansible is also expecting to be able to access both the WebServer and the AppServer passwrdless. You will manually need to create a SSH key on the Ansible Control Machine and manually add that key on both the WebServer and the AppServer.
