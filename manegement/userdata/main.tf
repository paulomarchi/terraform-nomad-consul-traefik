provider "aws_profile" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
}

data "template_file" "init" {
  template = "${file("${path.module}/${var.type_infra}_userdata.sh.tpl")}"

  vars {
    region           = "${var.aws_region}"
    nomad_region     = "${var.nomad_region}"
    prefix           = "${coalesce(var.nomad_prefix, var.datacenter, var.nomad_region, var.type_infra)}"
    datacenter       = "${var.datacenter}"
    ec2_tag_key      = "Service"
    ec2_tag_value    = "${var.ec2_tag_value}"
    bootstrap_expect = "${var.cluster_size}"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.init.rendered}"
  }
}