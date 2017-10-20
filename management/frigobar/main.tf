# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}


data "aws_ami" "standard" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["${var.image-search-path}"]
  }
}

module "frigobar-sg" {
  source                    = "../security-groups"
  namespace                 = "${var.namespace}"
  profile                   = "${var.profile}"
  region                    = "${var.region}"
  vpc_id                    = "${var.vpc_id}"
}

# Create Userdata 
module "frigobar-init" {
  source        = "../userdata"
  namespace     = "${var.namespace}"
  profile       = "${var.aws_profile}"
  region        = "${var.aws_region}"
  nomad_prefix  = "${var.nomad_prefix}"
  nomad_region  = "${var.nomad_region}"
  cluster_size  = "${var.cluster_size}"
  ec2_tag_value = "${var.ec2_tag_value}"
  datacenter    = "${var.datacenter}"
  type_infra    = "${var.type_infra}"
}

# Create Instance
module "cluster-instance" {
  source             = "../instance"
  userdata           = "${module.frigobar-init.userdata}"
  name_prefix        = "frigobar-${var.type_infra}"
  subnet_cidr_blocks = "${var.subnet_cidr_blocks}"
  namespace          = "${var.namespace}"
  vpc_id             = "${var.vpc_id}"
  security_groups    = "${module.frigobar-sg.id}"
  profile            = "${var.profile}"
  instance_type      = "${var.instance_type}"
  region             = "${var.region}"
  key_name           = "${var.key_name}"
  cluster_size       = "${var.cluster_size}"
  subnet_ids         = "${var.subnet_ids}"
  ec2_tag_value      = "${var.ec2_tag_value}"
  image-search-path  = "${data.aws_ami.standard.id}"
  ip_ini             = "${var.ip_ini}"
  subnet_cidr_blocks = "${var.subnet_cidr_blocks}"
}




