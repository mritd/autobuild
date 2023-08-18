#!/usr/bin/env bash

set -e

TRACKER_URL="https://cdn.staticaly.com/gh/XIU2/TrackersListCollection/master/best_aria2.txt"

if [ ! -f  ${XDG_DATA_HOME}/conf/aria2.conf ]; then
    mkdir -p ${XDG_DATA_HOME}/{conf,downloads}
    touch ${XDG_DATA_HOME}/conf/aria2.session
    cp /etc/aria2.conf ${XDG_DATA_HOME}/conf/aria2.conf
    sed -i "s@XDG_DATA_HOME@${XDG_DATA_HOME}@g" ${XDG_DATA_HOME}/conf/aria2.conf
    sed -i "s@bt-tracker=@bt-tracker=$(curl -sSL ${TRACKER_URL})@g" ${XDG_DATA_HOME}/conf/aria2.conf
fi

exec aria2c --conf-path=${XDG_DATA_HOME}/conf/aria2.conf
