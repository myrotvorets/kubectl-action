# kubectl-action

Provides `kubectl` command to GitHub Actions.

## Why?

Mainly because we need to be sure that our `kubeconfig` will not leak to third parties :-) We control the code, and we know there are no (and there will be no) backdoors.

## Parameters

  * `config`: base64-encoded `kubeconfig` (**required**);
  * `version`: kubectl version, defaults to `latest`. Supported versions: 1.18, 1.19, 1.20, 1.21. `latest` is aliased to the latest available version. See: [Kubernetes version skew policy](https://kubernetes.io/docs/setup/release/version-skew-policy/#kubectl);
  * `args`: parameters passed to `kubectl`.

## Usage

```yaml
name: Deploy
on:
  push:
    branches:
      - master

jobs:
  deploy:
    runs-on: ubuntu-latest

  steps:
    - uses: actions/checkout@v2
    - name: Deploy to cluster
      uses: myrotvorets/kubectl-action@2.0.0
      with:
        config: ${{ secrets.KUBE_CONFIG_DATA }}
        version: latest
        args: set image --record deployment/application container=${{ github.repository }}:${{ github.sha }}
    - name: Verify deployment
      uses: myrotvorets/kubectl-action@2.0.0
      with:
        config: ${{ secrets.KUBE_CONFIG_DATA }}
        version: latest
        args: rollout status deployment/application
```
