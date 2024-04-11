# output "dynamodb_endpoint_id" {
#   value = aws_vpc_endpoint.ddb_ep.id
# }
# output "dynamodb_endpoint_dns_name" {
#     value = aws_vpc_endpoint.ddb_ep.dns_entry[0].dns_name
# }
output "my_vpc_id" {
    value = aws_vpc.this.id
}
output "vpn_sn_az1_id" {
    value = aws_subnet.vpn_sn_az1.id
}
output "private_sn_az1_id" {
    value = aws_subnet.private_sn_az1.id
}
output "private_sn_az1" {
    value = aws_subnet.private_sn_az1.tags
}
