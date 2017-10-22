# Set Profile
variable "aws_profile" {
  description = "Insert your profile"
}

# Set Keypair
variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
}

# Set  Path Private Key
variable "path_private_key" {
  description = "Insert path private_key"
}

# AWS Regions
variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-2"
}

variable "image-search-path" {
  type        = "string"
  description = "search path for custom ami in the cluster"
  default     = "frigobar/pmarchi-centos-stable-standard*"
}

variable "instance_type" {
  type        = "string"
  description = "Instance type"
  default     = "t2.micro"  
}

variable "namespace" {
  type        = "string"
  description = "namespace used by prefixes and resources tags"
}

variable "cluster_size" {
  type        = "string"
  description = "size of the cluster"
  default     = 3
}

variable "datacenter" {
  type        = "string"
  description = "Datacenter will created by the module"
}

variable "ec2_tag_value" {
  type        = "string"
  default     = "frigobar"
  description = "tag value for join cluster"
}

variable "nomad_prefix" {
  type        = "string"
  description = "Prefix name will be used in nomad-servers agents"
}

variable "nomad_region" {
  type        = "string"
  description = "Group of datacenters with same geografic region ( us, eu, ...)"
}

variable "type_infra" {
  type        = "string"
  description = "The type of infra (server or client)"
}

variable "vpc_id" {
  type        = "string"
  description = "vpc-id default"
  default     = "vpc-d2843abb"
}

variable "subnet_ids" {
  type        = "string"
  description = "list of all subnets in cluster VPC"
}



