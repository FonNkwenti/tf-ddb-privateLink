

resource "aws_ec2_client_vpn_endpoint" "my_client_vpn" {
  description            = "My client vpn"
  server_certificate_arn = local.server_cert_arn
  client_cidr_block      = "10.100.0.0/22"
  vpc_id                 = aws_vpc.this.id
  
  security_group_ids     = [aws_security_group.vpn_sg.id]
  split_tunnel           = true

  # Client authentication
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = local.client_cert_arn
  }

  connection_log_options {
    enabled = false
   }

}

resource "aws_ec2_client_vpn_network_association" "client_vpn_association_private" {
    client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.my_client_vpn.id
    subnet_id = aws_subnet.vpn_sn_az1.id

    lifecycle {
      ignore_changes = [subnet_id]
    }

}

resource "aws_ec2_client_vpn_authorization_rule" "authorization_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.my_client_vpn.id
  
  target_network_cidr    = "10.0.0.0/16"
  authorize_all_groups   = true
}