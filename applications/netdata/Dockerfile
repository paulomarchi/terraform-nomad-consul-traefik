FROM centos:latest

RUN yum install epel-release -y

RUN  yum update -yum

# Requirements
RUN yum install git autoconf automake curl gcc git libmnl-devel libuuid-devel lm-sensors make MySQL-python nc pkgconfig python python-psycopg2 PyYAML zlib-devel zlib libuuid

# Plugins
RUN yum install iproute python-yaml python-mysqldb python-psycopg2 python-pymongo nodejs libmnl nc lm_sensors MySQL-python

RUN git clone https://github.com/firehol/netdata.git --depth=1 && \
    cd netdata && \
    ./netdata-installer.sh --install /opt --dont-start-it && \
    cp system/netdata.service /etc/systemd/system/ &&\
    systemctl daemon-reload && \
    systemctl enable netdata && \
    systemctl start netdata

# Memory de-duplication instructions
RUN echo 1 >/sys/kernel/mm/ksm/run && \
    echo 1000 >/sys/kernel/mm/ksm/sleep_millisecs

ENV NETDATA_PORT 19999
EXPOSE $NETDATA_PORT

CMD /opt/netdata/usr/sbin/netdata