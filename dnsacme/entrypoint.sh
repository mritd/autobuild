#!/usr/bin/env bash

set -ex

if [ ! -f /data/ssh_dnsacme ] || [ ! -f /data/ssh_dnsacme.pub ]; then
    ssh-keygen -t ed25519 -f /data/ssh_dnsacme -q -C dnsacme -N "" <<<y >/dev/null 2>&1
    echo >> /host_ssh/authorized_keys
    cat /data/ssh_dnsacme.pub >> /host_ssh/authorized_keys
fi

exec dnsacme
