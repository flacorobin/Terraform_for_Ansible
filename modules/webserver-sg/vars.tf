variable "webserver_sg_vpc_id" {
}

variable "webserver_sg_ssh_ip"{
  type = list
  default = ["0.0.0.0/0"]
}
