#!/usr/bin/env bash

set -ex

ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -q -C dnsacme -N ""
cat /root/.ssh/id_ed25519.pub >> /host_ssh/authorized_keys

exec dnsacme
