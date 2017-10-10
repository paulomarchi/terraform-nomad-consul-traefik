# Terraform - Nomad - Consul - Traefik - Example


The project launches a Nomad + Consul + Traefik using a Terraform

To run, configure your AWS provider as described in https://www.terraform.io/docs/providers/aws/index.html


Requeriments

    Terraform

Running the example

run `terraform apply -var 'aws_access_key={your_access_key}' -var 'aws_secret_key=your_secret_key' -var 'aws_key_name={your_keypair}' -var 'path_private_key={your_path_private_key}'`

