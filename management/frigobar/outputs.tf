output "instance_ids" {
  value = "${module.cluster-instance.instance_ids}"
}

output "address_instance_private" {
  value = "${module.cluster-instance.private_ips}"
}

output "address_instance_public_ip" {
  value = "${module.cluster-instance.public_ips}"
}
