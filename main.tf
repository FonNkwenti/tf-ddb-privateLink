# resource "aws_acm_certificate" "vpn_server" {
#   domain_name = "example-vpn.example.com"
#   validation_method = "DNS"

# #   tags = local.global_tags

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_acm_certificate" "server_vpn_cert" {
#   certificate_body  = var.server_cert
#   private_key       = var.server_private_key
# #   certificate_chain = var.ca_cert
# }

# resource "aws_acm_certificate" "client_vpn_cert" {
#   certificate_body  = var.client_cert
#   private_key       = var.client_private_key
# #   certificate_chain = var.ca_cert
# }

resource "aws_ec2_client_vpn_endpoint" "my_client_vpn" {
  description            = "My client vpn"
  server_certificate_arn = aws_acm_certificate.server_vpn_cert.arn
  client_cidr_block      = "10.100.0.0/22"
  vpc_id                 = local.vpc_id
  
  security_group_ids     = [aws_security_group.vpn_sg.id]
  split_tunnel           = true

  # Client authentication
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client_vpn_cert.arn
  }

  connection_log_options {
    enabled = false
   }

  depends_on = [
    aws_acm_certificate.server_vpn_cert,
    aws_acm_certificate.client_vpn_cert
  ]
}

resource "aws_ec2_client_vpn_network_association" "client_vpn_association_private" {
    client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.my_client_vpn.id
    subnet_id = local.vpn_sn_az1_id

}