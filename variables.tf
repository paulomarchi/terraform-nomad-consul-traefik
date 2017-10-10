# AWS Regions
variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-2"
}

# List Images
variable "aws_amis" {
  default = {
    "us-east-1" = "ami-8c1be5f6" # Amazon Linux AMI 2017.09.0 (HVM), SSD Volume Type
    "us-east-2" = "ami-c5062ba0" # Amazon Linux AMI 2017.09.0 (HVM), SSD Volume Type
  }
}

# Set Keypair
variable "aws_key_name" {
  description = "Name of the SSH keypair to use in AWS."
}

# Set  Path Private Key
variable "path_private_key" {
  description = "Insert path private_key"
}

# Set Server instance type
variable "nomad_server_instance_type" {
  description = "Server Instance Type"
  default     = "t2.micro"
}

# Set Node instance type
variable "nomad_node_instance_type" {
  description = "Node Instance Type"
  default     = "t2.medium"
}

# Set Access_Key
variable "aws_access_key" {
  description = "Insert your access_key"
}

# Set Secret_Key
variable "aws_secret_key" {
  description = "Insert your secret_key"
}
