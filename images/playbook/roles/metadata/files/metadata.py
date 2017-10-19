#!/usr/bin/env python3
import requests


def get_metadata():
    base_url = 'http://169.254.169.254/latest/meta-data'
    az = requests.get('%s/placement/availability-zone' % base_url).text
    return {
        'EC2_INSTANCE_ID': requests.get('%s/instance-id' % base_url).text,
        'EC2_LOCAL_IPV4': requests.get('%s/local-ipv4' % base_url).text,
        'EC2_PUBLIC_IPV4': requests.get('%s/public-ipv4' % base_url).text,
        'EC2_AZ': az[-1:],
        'EC2_REGION': az[0:-1],
        'EC2_REGION_GROUP': az[0:2]
    }


for kv in get_metadata().items():
    print('%s="%s"' % kv)