#!/usr/bin/env bash

if [ ! -f /root/.ssh/open-vm-tools ]; then
    ssh-keygen -t rsa -f /root/.ssh/open-vm-tools -q -P ""
fi

if [ ! -f /root/.ssh/authorized_keys ]; then
    touch /root/.ssh/authorized_keys
fi

PUBLIC_KEY=$(cat /root/.ssh/open-vm-tools.pub)

grep -q -F "${PUBLIC_KEY}" /root/.ssh/authorized_keys || echo ${PUBLIC_KEY} >> /root/.ssh/authorized_keys

exec /usr/bin/vmtoolsd
