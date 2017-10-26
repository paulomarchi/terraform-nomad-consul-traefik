output "server_instance_ids" {
  value = "${module.server.instance_ids}"
}

output "server_address_instance_private" {
  value = "${module.server.address_instance_private}"
}

output "server_address_instance_public_ip" {
  value = "${module.server.address_instance_public_ip}"
}

output "client_instance_ids" {
  value = "${module.client.instance_ids}"
}

output "client_address_instance_private" {
  value = "${module.client.address_instance_private}"
}

output "client_address_instance_public_ip" {
  value = "${module.client.address_instance_public_ip}"
}
