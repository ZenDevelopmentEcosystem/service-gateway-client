#!/usr/bin/env bash

set -eu -o pipefail

function cleanup() {
    if [ -n "${LISTENING_NETCAT:-}" ]; then
        kill "${LISTENING_NETCAT}"
    fi
    if [ -S /tmp/.ssh-servicegw-client ]; then
        ssh -F ssh_config -S /tmp/.ssh-servicegw-client -O exit servicegwd-client
    fi
    if [ -S /tmp/.ssh-servicegw-admin ]; then
        ssh -F ssh_config -S /tmp/.ssh-servicegw-admin -O exit servicegwd-admin
    fi
}

trap cleanup EXIT

SERVER=10.0.0.32
SERVICE_PORT=11111
ADMIN_PORT=11112

netcat -k -l ${SERVICE_PORT} &
LISTENING_NETCAT=$!
echo "Service PID=$LISTENING_NETCAT"

ssh -F ssh_config -f -N -R ${SERVER}:${SERVICE_PORT}:localhost:${SERVICE_PORT} -M -S /tmp/.ssh-servicegw-client servicegwd-client
ssh -F ssh_config -S /tmp/.ssh-servicegw-client -O check servicegwd-client

ssh -F ssh_config -f -N -L ${ADMIN_PORT}:localhost:${SERVICE_PORT} -M -S /tmp/.ssh-servicegw-admin servicegwd-admin
ssh -F ssh_config -S /tmp/.ssh-servicegw-admin -O check servicegwd-admin

echo "hello over netcat" | netcat -N localhost ${ADMIN_PORT}
