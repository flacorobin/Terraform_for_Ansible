output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}

output "public_sn_id" {
  value = aws_subnet.public_sn.*.id
}

output "private_sn_id" {
  value = aws_subnet.private_sn.*.id
}

output "cidr_block" {
  value = aws_vpc.custom_vpc.cidr_block
}
