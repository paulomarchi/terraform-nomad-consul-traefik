module "frigobar-sg" {
  source      = "../security-groups"
  aws_profile = "${var.aws_profile}"
  aws_region  = "${var.aws_region}"
  vpc_id      = "${var.vpc_id}"
}

module "server" {
  source          = "../frigobar"
  aws_profile     = "${var.aws_profile}"
  datacenter      = "${var.datacenter}"
  key_name        = "${var.key_name}"
  namespace       = "${var.namespace}"
  nomad_prefix    = "${var.nomad_prefix}"
  nomad_region    = "${var.nomad_region}"
  subnet_ids      = "${var.subnet_ids}"
  type_infra      = "server"
  security_groups = "${module.frigobar-sg.id}"
}

module "client" {
  source          = "../frigobar"
  aws_profile     = "${var.aws_profile}"
  datacenter      = "${var.datacenter}"
  key_name        = "${var.key_name}"
  namespace       = "${var.namespace}"
  nomad_prefix    = "${var.nomad_prefix}"
  nomad_region    = "${var.nomad_region}"
  subnet_ids      = "${var.subnet_ids}"
  type_infra      = "client"
  security_groups = "${module.frigobar-sg.id}"
}
