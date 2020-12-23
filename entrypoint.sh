#!/bin/sh

set -e

echo "$KUBE_CONFIG_DATA" | base64 -d > /tmp/kubeconfig
export KUBECONFIG=/tmp/kubeconfig

exec /usr/bin/kubectl $*
