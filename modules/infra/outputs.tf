output "public_ip_v4" {
  value = aws_eip.elastic_ip.*.public_ip
}
output "public_ip_v6" {
  value = aws_vpc.vpc.ipv6_cidr_block
}