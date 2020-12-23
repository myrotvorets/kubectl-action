# kubectl-action

Provides `kubectl` command to GitHub Actions.

## Why?

Mainly because we need to be sure that our kubeconfig won't leak to third parties :-) We control the code, we know there are no (and there will be no) backdoors.

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
      uses: myrotvorets/run-kubectl@master
      env:
        KUBE_CONFIG_DATA: ${{ secrets.KUBE_CONFIG_DATA }}
      with:
        args: set image --record deployment/application container=${{ github.repository }}:${{ github.sha }}
    - name: Verify deployment
      uses: myrotvorets/run-kubectl@master
      env:
        KUBE_CONFIG_DATA: ${{ secrets.KUBE_CONFIG_DATA }}
      with:
        args: rollout status deployment/application
```
