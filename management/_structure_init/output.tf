output "server_instance_ids" {
  value = "${module.server.instance_ids}"
}

output "server_address_instance_private" {
  value = "${module.server.private_ips}"
}

output "server_address_instance_public_ip" {
  value = "${module.server.public_ips}"
}
