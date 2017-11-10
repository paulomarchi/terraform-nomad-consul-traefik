#!/bin/bash -eux

# Gathering Instance Data
metadata > /etc/nosce/metadata

# Consul Server Conf
cat << EOF > /etc/consul/conf.d/server.json
{
  "ui" : true,
	"server": true,
	"bootstrap_expect": ${bootstrap_expect},
	"datacenter": "${datacenter}",
	"retry_join_wan": [ "provider=aws region=${region} tag_key=${ec2_tag_key} tag_value=${ec2_tag_value}" ],
	"retry_join": [ "provider=aws region=${region} tag_key=${ec2_tag_key} tag_value=${ec2_tag_value}" ]
}
EOF

chown consul:consul /etc/consul/conf.d/server.json

cat << EOF > /etc/nosce/consul
CONSUL_EC2_KEY="${ec2_tag_key}"
CONSUL_EC2_VALUE="${ec2_tag_value}"
EOF

# Nomad Server Conf
cat << EOF > /etc/nomad/conf.d/server.json
{
  "server": {
    "enabled" : true, 
    "bootstrap_expect" : ${bootstrap_expect}
  },
  "region" : "${nomad_region}",
  "datacenter" : "${datacenter}",
  "consul": {
    "address": "localhost:8500",
    "server_service_name" : "${prefix}-nomad",
    "client_service_name" : "${prefix}-nomad-client"
  }
}
EOF

chown nomad:nomad /etc/nomad/conf.d/server.json

# http://dustymabe.com/2015/08/03/installingstarting-systemd-services-using-cloud-init/
systemctl enable --now --no-block consul
systemctl enable --now --no-block nomad
