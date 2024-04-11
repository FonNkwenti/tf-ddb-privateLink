
output "my_vpc_id" {
    value = aws_vpc.this.id
}
output "vpn_sn_az1_id" {
    value = aws_subnet.vpn_sn_az1.id
}
output "private_sn_az1_id" {
    value = aws_subnet.private_sn_az1.id
}
output "client_vpn_ep_id" {
    value = aws_ec2_client_vpn_endpoint.my_client_vpn.id
}
output "ddb_ep_id" {
    value = aws_vpc_endpoint.ddb_ep.id
}
output "ddb_ep_dns" {
    value = aws_vpc_endpoint.ddb_ep.dns_entry[0]["dns_name"]
}
