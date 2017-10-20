#!/bin/bash -eux

metadata > /etc/nosce/metadata

cat << EOF > /etc/consul/conf.d/client.json
{
  "datacenter": "${datacenter}",
  "retry_join": [ "provider=aws region=${region} tag_key=${ec2_tag_key} tag_value=${ec2_tag_value}" ],
  "retry_join_wan": [ "provider=aws region=${region} tag_key=${ec2_tag_key} tag_value=${ec2_tag_value}" ]
}
EOF

chown consul:consul /etc/consul/conf.d/client.json

cat << EOF > /etc/nosce/consul
CONSUL_EC2_KEY="${ec2_tag_key}"
CONSUL_EC2_VALUE="${ec2_tag_value}"
EOF

cat << EOF > /etc/nomad/conf.d/client.json
{
  "client": {
    "enabled": true,
    "network_speed": 10,
    "node_class": "${nomad_class}"
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

chown nomad:nomad /etc/nomad/conf.d/client.json


cat << EOF > /etc/nosce/nomad
NOMAD_OPTIONS=""
EOF

# http://dustymabe.com/2015/08/03/installingstarting-systemd-services-using-cloud-init/
systemctl enable --now --no-block consul
systemctl enable --now --no-block nomad
