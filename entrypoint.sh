#!/bin/sh

set -e

echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/kubeconfig
export KUBECONFIG=/tmp/kubeconfig

exec /usr/bin/kubectl $*
