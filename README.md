# Terraform - Nomad - Consul - Traefik - Example

The project launches a Nomad + Consul + Traefik using Packer and Terraform

To run, configure your AWS provider as described in https://www.terraform.io/docs/providers/aws/index.html

Requeriments
    AWS Account
    AWS Cli
    Packer
    Terraform

## Running the example

### Download and install modules for the configuration
```
$ terraform get
```
### Generate and show an execution plan
```
$ `terraform plan -var 'aws_profile={your_profile}' -var 'datacenter={your_datacenter}' -var 'key_name={your_keyname}' -var 'namespace={your_namespace}' -var 'nomad_prefix={your_prefix}' -var 'nomad_region={your_nomd_region}' -var 'subnet_ids=["{your_subnets_id}}"]'`
```

### Builds or changes infrastructure
```
$ `terraform apply -var 'aws_profile={your_profile}' -var 'datacenter={your_datacenter}' -var 'key_name={your_keyname}' -var 'namespace={your_namespace}' -var 'nomad_prefix={your_prefix}' -var 'nomad_region={your_nomd_region}' -var 'subnet_ids=["{your_subnets_id}}"]'`
```

Docs
 Armon Dadgar @armon
 https://cdn.oreillystatic.com/en/assets/1/event/244/Nomad%20and%20next-generation%20application%20architectures%20Presentation.pdf
