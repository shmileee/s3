# Kubernetes

Deploy Helm charts using Ansible. Helm binaries are installed using `gantsign.helm` role from Ansible Galaxy.

## Requirements

Requires pipenv, ansible >= 2.9.7. 
Install dependencies:

    sudo apt install pipenv
    pipenv install

## Role Variables

For default variables used please refer to roles fetched via ansible-galaxy documentation. Custom variables are under `inventories/<project>/<environment>/group_vars`):

    kubernetes_namespace: default
    chart_repo: "https://kubernetes-charts.storage.googleapis.com"

## Deployment

After requirements are met, deployment can be triggered using `ansible-playbook`. 

## Examples

Deploy MySQL helm chart:
- `ansible-playbook -i inventories/s3group/dev/inventory playbooks/mysql.yml`

## Misc 
- `make clean` removes all roles specified in `requirements.yml`.