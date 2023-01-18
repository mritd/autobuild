#!/usr/bin/env bash

set -ex

CERT_PATH="/host_certs/$(ssh root@127.0.0.1 uname -n)_unraid_bundle.pem"

echo ${ACME_CERT_PATH} > ${CERT_PATH}
echo ${ACME_KEY_PATH} >> ${CERT_PATH}

ssh root@127.0.0.1 /etc/rc.d/rc.nginx reload
