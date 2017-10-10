# Specify the provider and access details
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"

}

resource "aws_eip" "default" {
  instance = "${aws_instance.server.id}"
  vpc      = true
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "server"
  description = "Used in the terraform"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 4647
    to_port     = 4647
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Nomad Instance Server
resource "aws_instance" "server" {
  instance_type = "${var.nomad_server_instance_type}"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "${var.aws_key_name}"

  # Our Security group to allow HTTP and SSH access
  security_groups = ["${aws_security_group.default.name}"]

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
  user_data = "${file("userdata/userdata_server.sh")}"

  #Instance tags
  tags {
    Name = "nomade-server1-simulate-paulomarchi"
  }

  # Copies the server.hcl file to /opt/nomad/conf/server.hcl
  provisioner "file" {
    source      = "conf/server.hcl"
    destination = "/opt/nomad/server.hcl"

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = "${var.path_private_key}/${var.aws_key_name}.pem"
    }
  }
} 

resource "aws_instance" "node1" {
  instance_type = "${var.nomad_node_instance_type}"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "${var.aws_key_name}"

  # Our Security group to allow HTTP and SSH access
  security_groups = ["${aws_security_group.default.name}"]

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
  user_data = "${file("userdata/userdata_node.sh")}"

  #Instance tags
  tags {
    Name = "nomad-node1-simulate-paulomarchi"
  }

  # Copies the server.hcl file to /opt/nomad/conf/server.hcl
  provisioner "file" {
    source      = "conf/client.hcl"
    destination = "/opt/nomad/client.hcl"

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = "${var.path_private_key}/${var.aws_key_name}.pem"
    }
  }
}
