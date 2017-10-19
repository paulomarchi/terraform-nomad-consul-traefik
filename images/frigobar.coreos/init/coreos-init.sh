#!/bin/bash -uxe
VERSIONS=${VERSIONS:-"2.7.13.2715"}
PACKAGE=ActivePython-${VERSIONS}-linux-x86_64-glibc-2.12-402695

# make directory
mkdir -p /opt/bin
cd /opt

# Download Package
wget http://downloads.activestate.com/ActivePython/releases/${VERSIONS}/${PACKAGE}.tar.gz
tar -xzvf ${PACKAGE}.tar.gz

mv ${PACKAGE} apy && cd apy && ./install.sh -I /opt/python/

# ln -sf /opt/python/bin/easy_install /opt/bin/easy_install
# ln -sf /opt/python/bin/pip2 /opt/bin/pip2
# ln -sf /opt/python/bin/pip /opt/bin/pip
# ln -sf /opt/python/bin/python /opt/bin/python
# ln -sf /opt/python/bin/python /opt/bin/python2
# ln -sf /opt/python/bin/virtualenv /opt/bin/virtualenv

# PATH
cat > ~/.bashrc << EOF
export PATH=/opt/python/bin:$PATH
EOF

# Install Ansible
pip install ansible

# ln -s /opt/python/bin/ansible /opt/bin/ansible
# ln -s /opt/python/bin/ansible-playbook /opt/bin/ansible-playbook
# ln -s /opt/python/bin/ansible-config /opt/bin/ansible-config
# ln -s /opt/python/bin/ansible-inventory /opt/bin/ansible-inventory
