#!/usr/bin/env bash

set -ex

CERT_PATH="/host_certs/$(ssh -i /data/dnsacme -o StrictHostKeyChecking=no -o UserKnownHostsFile /dev/null root@127.0.0.1 uname -n)_unraid_bundle.pem"

echo ${ACME_CERT_PATH} > ${CERT_PATH}
echo ${ACME_KEY_PATH} >> ${CERT_PATH}

ssh -i /data/dnsacme -o StrictHostKeyChecking=no -o UserKnownHostsFile /dev/null root@127.0.0.1 /etc/rc.d/rc.nginx reload
