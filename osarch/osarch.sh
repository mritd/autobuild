#!/usr/bin/env sh

set -e

os_arch=$(uname -m)
case $os_arch in
  x86_64) echo "amd64" ;;
  x86) echo "386" ;;
  i686) echo "386" ;;
  i386) echo "386" ;;
  aarch64) echo "arm64" ;;
  armv5*) echo "armv5" ;;
  armv6*) echo "armv6" ;;
  armv7*) echo "armv7" ;;
esac
