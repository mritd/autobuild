#!/usr/bin/env bash

set -e

SSH_CMD="ssh -i /data/ssh_dnsacme -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR root@127.0.0.1"
CERT_PATH="/host_certs/$(${SSH_CMD} uname -n)_unraid_bundle.pem"

cat ${ACME_CERT_PATH} ${ACME_KEY_PATH} > ${CERT_PATH}

${SSH_CMD} /etc/rc.d/rc.nginx reload
