variable "aws_profile" {
  "type"      = "string"
  description = "AWS profile name"
}

variable "aws_region" {
  "type"      = "string"
  description = "Region of the resources"
}

variable "namespace" {
  type        = "string"
  description = "namespace used by prefixes and resources tags"
}
