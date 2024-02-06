#!/usr/bin/env sh

set -e

os_arch=$(uname -m 2>/dev/null || echo "unknown")
case $os_arch in
  x86_64 | amd64)
      echo "amd64"
      ;;
  i386 | i486 | i586 | i686 | x86)
      echo "386"
      ;;
  arm64 | aarch64)
      echo "arm64"
      ;;
  armv5*)
      echo "armv5"
      ;;
  armv6*)
      echo "armv6"
      ;;
  armv7*)
      echo "armv7"
      ;;
  *)
      echo "unknown"
      ::
esac
