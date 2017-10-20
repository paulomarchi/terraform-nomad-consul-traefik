output "instance_ids" {
  value = "${aws_instance.node.*.id}"
}

output "private_ips" {
  value = "${aws_instance.node.*.private_ip}"
}

output "public_ips" {
  value = "${aws_instance.node.*.public_ip}"
}
