#!/usr/bin/env bash

set -e

if [ ! -f /data/conf/aria2.conf ]; then
    mkdir -p /data/conf
    cp /etc/aria2.conf /data/conf
fi

exec aria2c --conf-path=/data/conf/aria2.conf
