#!/bin/sh

set -e

echo "${KUBE_CONFIG_DATA:-}" | base64 -d > /tmp/kubeconfig
export KUBECONFIG=/tmp/kubeconfig

trap 'cleanup' 0 HUP INT QUIT ABRT TERM

cleanup() {
    rm -f "${KUBECONFIG}"
}

/usr/bin/kubectl "$@"
