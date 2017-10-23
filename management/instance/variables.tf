variable "aws_profile" {
  type        = "string"
  description = "AWS profile name"
}

variable "aws_region" {
  type        = "string"
  description = "Region of the resources"
}

variable "image-search-path" {
  type        = "string"
  description = "search path for custom ami in the cluster"
}

variable "namespace" {
  type        = "string"
  description = "namespace used by prefixes and resources tags"
}

variable "name_prefix" {
  type        = "string"
  description = "name prefix used with namespace for define a job"
}

variable "key_name" {
  type        = "string"
  description = "Key Name used in the cluster servers (ssh_key)"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC from the cluster"
  default     = "vpc-d2843abb"
}

variable "instance_type" {
  type        = "string"
  description = "AWS type of the instance node"
  default     = "t2.micro"
}

variable "subnet_ids" {
  type        = "list"
  description = "list of all subnets in cluster VPC"
}

variable "cluster_size" {
  type        = "string"
  description = "size of the cluster"
  default     = 3
}

variable "security_groups" {
  type        = "string"
  description = "security groups from the cluster"
}

variable "userdata" {
  type        = "string"
  description = "userdata from the cluster"
}

variable "ec2_tag_value" {
  type        = "string"
  default     = "brastemp"
  description = "tag value for join cluster"
}
