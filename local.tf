
data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners     = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/vpc/eu-central-1/my-vpc"
}

data "aws_ssm_parameter" "vpn_sn_az1_id" {
  name  = "/vpc/eu-central-1/vpn-sn-az1"
}

data "aws_ssm_parameter" "private_sn_az1_id" {
  name  = "/vpc/eu-central-1/private-sn-az1"
}
locals {
  ddb_table_name  = "todo-table"
  env             = "dev"
  az1             = data.aws_availability_zones.available.names[0]
  az2             = data.aws_availability_zones.available.names[1]
  ami             = data.aws_ami.amazon_linux_2.id
  vpc_id          = data.aws_ssm_parameter.vpc_id.value
  vpn_sn_az1_id   = data.aws_ssm_parameter.vpn_sn_az1_id.value
  private_sn_az1_id = data.aws_ssm_parameter.private_sn_az1_id.value
  region          = var.region
  account_id      = data.aws_caller_identity.current.account_id

}