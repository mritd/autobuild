#!/usr/bin/env bash

set -e

function install_pkg(){
    sudo apt install jq qemu binfmt-support qemu-user-static -y
}


function init_earthly(){
     sudo wget -q -O /usr/local/bin/earthly $(curl -sL https://api.github.com/repos/earthly/earthly/releases/latest \
         | jq -r '.assets[].browser_download_url' | grep earthly-linux-amd64)
     sudo chmod +x /usr/local/bin/earthly
}

function build(){
    earthly --push +all
}

install_pkg
init_earthly
build
