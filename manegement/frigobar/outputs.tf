output "address_server" {
  value = "${aws_instance.server.private_ip}"
}

output "address_node1" {
  value = "${aws_instance.node1.private_ip}"
}

output "elastic ip" {
  value = "${aws_eip.default.public_ip}"
}
