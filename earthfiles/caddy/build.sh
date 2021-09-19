#!/usr/bin/env bash

set -e

source ../_common.sh

function build(){
    earthly -P --build-arg VERSION=$(cat version) --push +all
    git config --global user.name mritd
    git config --global user.email mritd@linux.com
    git pull https://mritd:${COMMIT_TOKEN}@github.com/mritd/autobuild.git
    git add version
    git commit -m "$(cat version): GitHub Action Auto Update(`date +'%Y-%m-%d %H:%M:%S'`)"
    git push https://mritd:${COMMIT_TOKEN}@github.com/mritd/autobuild.git
}

install_pkg

latest_version=$(curl -s "https://api.github.com/repos/caddyserver/caddy/releases/latest" | jq -r .tag_name)
latest_build_version=$(cat version)

if [ "${latest_version}" != "${latest_build_version}" ]; then
    echo ${latest_version} > version
    init_earthly
    build
else
    echo -e "\033[1;32mNo update found.\033[0m"
fi
