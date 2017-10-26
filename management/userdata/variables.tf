variable "aws_profile" {
  description = "Insert your profile"
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-2"
}

variable "type_infra" {
  type        = "string"
  description = "The type of infra (server or client)"
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
  description = "Datacenter will created by the module (dc2a, dc2b, ...)"
}

variable "ec2_tag_value" {
  type        = "string"
  default     = "frigobar"
  description = "tag value for join cluster"
}

variable "nomad_prefix" {
  type        = "string"
  description = "Prefix name will be used in nomad-servers agents (frigobar)"
}

variable "nomad_region" {
  type        = "string"
  description = "Group of datacenters with same geografic region ( ueast2a, useast2b, ...)"
}

variable "nomad_class" {
  type        = "string"
  description = "Class name will be used in nomad-clients agents, will be used a constraint of services"
  default     = "linux-64bit"
}
