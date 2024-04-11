resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "my-vpc"
  }

}


resource "aws_subnet" "vpn_sn_az1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "vpn-sn-az1"
  }
}

resource "aws_route_table" "vpn_rt_az1" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "vpn_rt_az1"
  }
}

resource "aws_route_table_association" "vpn_rta1_az1" {
  subnet_id      = aws_subnet.vpn_sn_az1.id
  route_table_id = aws_route_table.vpn_rt_az1.id
}

resource "aws_subnet" "private_sn_az1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "private-sn-az1"
  }
}

resource "aws_route_table" "private_rt_az1" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "private_rt_az1"
  }
}

resource "aws_route_table_association" "private_rta1_az1" {
  subnet_id      = aws_subnet.private_sn_az1.id
  route_table_id = aws_route_table.private_rt_az1.id
}


# #############################################
# store VPC values in SSM
################################################

resource "aws_ssm_parameter" "vpc_id" {
  name  = "/vpc/${var.region}/${aws_vpc.this.tags["Name"]}"
  type  = "String"
  value = aws_vpc.this.id
  tags = {
    Sensitive = "true"
    Project = var.tag_project
    Environment = var.tag_environment
  }
}
resource "aws_ssm_parameter" "vpn_sn_az1_id" {
  name  = "/vpc/${var.region}/${aws_subnet.vpn_sn_az1.tags["Name"]}"
  type  = "String"
  value = aws_subnet.vpn_sn_az1.id
  tags = {
    Sensitive = "true"
    Project = var.tag_project
    Environment = var.tag_environment
  }
}
resource "aws_ssm_parameter" "private_sn_az1_id" {
  name  = "/vpc/${var.region}/${aws_subnet.private_sn_az1.tags["Name"]}"
  type  = "String"
  value = aws_subnet.private_sn_az1.id
  tags = {
    Sensitive = "true"
    Project = var.tag_project
    Environment = var.tag_environment
  }
}



# resource "aws_vpc_endpoint" "ddb_ep" {
#   vpc_endpoint_type   = "Interface"
#   private_dns_enabled = true
#   service_name        = "com.amazonaws.${var.region}.dynamodb"

#   vpc_id              = aws_vpc.this.id
#   security_group_ids  = [aws_security_group.ddb_ep_sg.id]
#   subnet_ids          = [aws_subnet.vpn_sn_az1.id]
#   tags = {
#     Name = "dynamodb-endpoint"
#   }
# }
