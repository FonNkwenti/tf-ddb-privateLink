variable "region" {
  type    = string
  default = "us-east-1"
}
variable "account_id" {
  type    = number
  default = 123456789012
}

variable "tag_environment" {
  type    = string
  default = "dev"
}

variable "tag_project" {
  type    = string
  default = "my-tf-project"
}

variable "domain" {
  default = "tf-private-ddb.com"
}

# variable "server_cert" {
#   description = "Server certificate"
# }

# variable "client_cert" {
#   description = "Client/Root certificate"
# }
