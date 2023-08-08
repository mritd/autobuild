#!/usr/bin/env bash

set -e

SNELL_PORT=${SNELL_PORT:-5225}
SNELL_PSK=${SNELL_PSK:-$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 32)}
SHELL_IPV6=${SNELL_IPV6:-false}

cat > /etc/snell-server.conf <<EOF
[snell-server]
listen = 0.0.0.0:${SNELL_PORT}
psk = ${SNELL_PSK}
ipv6 = ${SNELL_IPV6}
EOF

exec snell-server --config /etc/snell-server.conf
