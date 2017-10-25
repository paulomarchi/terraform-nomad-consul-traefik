# Specify the provider and access details
provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

# module "frigobar-sg" {
#   source      = "../security-groups"
#   aws_profile = "${var.aws_profile}"
#   aws_region  = "${var.aws_region}"
#   vpc_id      = "${var.vpc_id}"
# }

# Create Userdata 
module "frigobar-init" {
  source        = "../userdata"
  namespace     = "${var.namespace}"
  aws_profile   = "${var.aws_profile}"
  aws_region    = "${var.aws_region}"
  nomad_prefix  = "${var.nomad_prefix}"
  nomad_region  = "${var.nomad_region}"
  cluster_size  = "${var.cluster_size}"
  ec2_tag_value = "${var.ec2_tag_value}"
  datacenter    = "${var.datacenter}"
  type_infra    = "${var.type_infra}"
}

# Create Instance
module "cluster-instance" {
  source      = "../instance"
  userdata    = "${module.frigobar-init.userdata}"
  name_prefix = "frigobar-${var.type_infra}"
  namespace   = "${var.namespace}"
  vpc_id      = "${var.vpc_id}"

  # security_groups   = "${module.frigobar-sg.id}"
  security_groups   = "${var.security_groups}"
  aws_profile       = "${var.aws_profile}"
  instance_type     = "${var.instance_type}"
  aws_region        = "${var.aws_region}"
  key_name          = "${var.key_name}"
  cluster_size      = "${var.cluster_size}"
  subnet_ids        = "${var.subnet_ids}"
  ec2_tag_value     = "${var.ec2_tag_value}"
  image-search-path = "${var.image-search-path}"
}
