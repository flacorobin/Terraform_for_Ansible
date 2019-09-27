#!bin/bash
#Bootscript for web WebServers

yum update -y
echo "Installed Updates" >> /home/ec2-user/messages.log
yum install python3 -y
echo "Installed Python3" >> /home/ec2-user/messages.log
yum install git -y
echo "Installed git" >> /home/ec2-user/messages.log
sudo -H -u ec2-user bash -c "pip-3 install --user ansible"
echo "Installed Ansible" >> /home/ec2-user/messages.log
sudo -H -u ec2-user bash -c "git clone https://github.com/flacorobin/Ansible.git /home/ec2-user/ansible"
echo "Cloned git" >> /home/ec2-user/messages.log
