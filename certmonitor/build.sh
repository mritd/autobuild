#!/usr/bin/env bash

set -e

source ../_common.sh

function build(){
    earthly --push +all
}

install_pkg
init_earthly
build
