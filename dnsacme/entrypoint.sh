#!/usr/bin/env bash

set -ex

if [ ! -f /data/dnsacme ] || [ ! -f /data/dnsacme.pub ]; then
    ssh-keygen -t ed25519 -f /data/dnsacme -q -C dnsacme -N "" <<<y >/dev/null 2>&1
    echo >> /host_ssh/authorized_keys
    cat /data/dnsacme.pub >> /host_ssh/authorized_keys
fi

exec dnsacme
