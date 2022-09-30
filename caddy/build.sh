#!/usr/bin/env bash

set -e

source ../_common.sh

function build(){
    curl -s "https://api.github.com/repos/caddyserver/caddy/releases/latest" | jq -r .tag_name > version
    earthly -P --build-arg VERSION=$(cat version) --push +all
}

install_pkg
init_earthly
build
