#!/usr/bin/env bash

set -e

TRACKER_URL="https://cdn.staticaly.com/gh/XIU2/TrackersListCollection/master/best_aria2.txt"

if [ ! -f /data/conf/aria2.conf ]; then
    mkdir -p /data/{conf,downloads}
    touch /data/conf/aria2.session
    cp /etc/aria2.conf /data/conf/aria2.conf
    sed -i "s@bt-tracker=@bt-tracker=$(curl -sSL ${TRACKER_URL})@g" /data/conf/aria2.conf
fi

exec aria2c --conf-path=/data/conf/aria2.conf
