#!/usr/bin/env bash

set -ex

git clone https://github.com/RMerl/am-toolchains ${BUILD_USER_HOME}/am-toolchains
git clone https://github.com/RMerl/asuswrt-merlin.ng.git ${BUILD_USER_HOME}/asuswrt-merlin.ng
chown -R ${BUILD_USER}:${BUILD_USER} ${BUILD_USER_HOME}
