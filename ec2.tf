
# resource "aws_instance" "vpn_instance" {
#   ami                    = local.ami 
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.vpn_sn_az1.id
#   vpc_security_group_ids = [aws_security_group.instance_sg.id, ]
# #   iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name

#   tags = {
#     Name = "vpn-instance"
#   }
# }

# # instance in the api-vpc required in part 1 to test the private API within the same VPC
# resource "aws_instance" "private_instance" {
#   ami                    = local.ami
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.private_sn_az1.id
#   vpc_security_group_ids = [ aws_security_group.instance_sg.id]
# #   iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name

#   tags = {
#     Name = "private-instance"
#   }
# }
