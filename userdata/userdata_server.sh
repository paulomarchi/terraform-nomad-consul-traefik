#!/bin/bash -v

# Install Nomad
cd /opt
wget --quiet https://releases.hashicorp.com/nomad/0.6.3/nomad_0.6.3_linux_amd64.zip
unzip nomad_0.6.3_linux_amd64.zip
rm -f nomad_0.6.3_linux_amd64.zip
mv nomad /usr/local/bin
mkdir -p nomad/conf

# Start Server
nomad agent -config /opt/nomad/conf/server.hcl

