#!/usr/bin/env bash

set -ex

ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -q -C dnsacme -N "" <<<y >/dev/null 2>&1
cat /root/.ssh/id_ed25519.pub >> /host_ssh/authorized_keys

exec dnsacme
