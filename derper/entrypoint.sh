#!/usr/bin/env bash

set -e

cmd="derper"

if [ "$#" -eq 0 ]; then
    
    if [ -n "${DERP_ADDR}" ]; then
        cmd+=" -a=${DERP_ADDR}"
    fi
    
    if [ -n "${DERP_HTTP_PORT}" ]; then
        cmd+=" --http-port=${DERP_HTTP_PORT}"
    fi
    
    if [ -n "${DERP_DOMAIN}" ]; then
        cmd+=" --hostname=${DERP_DOMAIN}"
    fi
    
    if [ -n "${DERP_CERT_MODE}" ]; then
        cmd+=" --certmode=${DERP_CERT_MODE}"
    fi
    
    if [ -n "${DERP_CERT_DIR}" ]; then
        cmd+=" --certdir=${DERP_CERT_DIR}"
    fi
    
    if [ -n "${DERP_STUN}" ]; then
        cmd+=" --stun=${DERP_STUN}"
    fi
    
    if [ -n "${DERP_STUN_PORT}" ]; then
        cmd+=" --stun-port=${DERP_STUN_PORT}"
    fi
    
    if [ -n "${DERP_VERIFY_CLIENTS}" ]; then
        cmd+=" --verify-clients=${DERP_VERIFY_CLIENTS}"
    fi

    echo "Run Command: ${cmd}"
    
    exec ${cmd}
else
    exec $@
fi
