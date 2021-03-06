![stability-wip](https://img.shields.io/badge/stability-work_in_progress-lightgrey.svg)

# Packer - Terraform - Nomad - Consul - Traefik

The project was created to learn more about Nomad, Consul and Trafik using Packer and Terraform tools. All the infrastructure are performing in Amazon Web Services.
Feel free to contribute.

## Requeriments
   * **AWS Account:** https://console.aws.amazon.com
   * **AWS Cli:** http://docs.aws.amazon.com/pt_br/cli/latest/userguide/installing.html
   * **Packer:** https://www.packer.io/
   * **Terraform:** https://www.terraform.io/

## Running the example

### Packer
#### Check that a template is valid
````
$ packer validate images/frigobar.centos/ami.json
````
#### Build image(s) from template
```
$ packer build -var 'profile={your_profile}' images/frigobar.centos/ami.json
```
### Terraform
#### Download and install modules for the configuration
```
$ cd management/_structure_init
$ terraform get
```
#### Generate and show an execution plan
```
$ terraform plan -var-file="init_data.tfvars"
```

#### Builds or changes infrastructure
```
$ terraform apply -var-file="init_data.tfvars"
```
#### Read an output from a state file
```
$ terraform output
```

### Nomad
```
$ export NOMAD_ADDR=http://18.216.245.253:4646
$ nomad status
```

### Consul
```
export CONSUL_HTTP_ADDR=18.216.245.253:8500
````

## Docs
 * **Armon Dadgar @armon:** [Presentation.pdf](https://cdn.oreillystatic.com/en/assets/1/event/244/Nomad%20and%20next-generation%20application%20architectures%20Presentation.pdf)
 * **Nomad:**  [Getting Started](https://www.nomadproject.io/intro/index.html)
 * **Consul:** [Getting Started](https://www.consul.io/intro/index.html)
 * **Pluralsight:** [Consul Getting Started](https://www.pluralsight.com/courses/consul-getting-started)
 * **Terraform Getting Started:** https://www.terraform.io/intro/index.html)
 * **Packer:** [Getting Started](https://www.packer.io/intro/index.html)

# TODO
* **Finish image frigobar.amz**
* **Finish image frigobar.coreos**
* **Create infrastructure Traefik**
