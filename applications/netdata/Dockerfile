FROM centos:latest

RUN yum install epel-release -y

# Requirements
RUN yum install git autoconf automake curl gcc git libmnl-devel libuuid-devel lm_sensors make \
    MySQL-python nc pkgconfig python python-psycopg2 PyYAML zlib-devel zlib libuuid net-tools -y

# Plugins
RUN yum install iproute python-yaml python-psycopg2 python-pymongo nodejs libmnl nc lm_sensors MySQL-python -y

RUN git clone https://github.com/firehol/netdata.git --depth=1 && \
    cd netdata && \
    ./netdata-installer.sh --install /opt --dont-start-it --dont-wait

ENV NETDATA_PORT 19999
EXPOSE ${NETDATA_PORT}

CMD /opt/netdata/usr/sbin/netdata -D -p ${NETDATA_PORT}