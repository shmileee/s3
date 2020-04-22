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

### Deploy MySQL
`ansible-playbook -i inventories/s3group/dev/inventory playbooks/mysql.yml`
or
`make mysql`

        root@host:~# helm list -a
        NAME            NAMESPACE       REVISION        UPDATED                                         STATUS          CHART                           APP VERSION  
        custom-mysql    default         1               2020-04-22 16:53:07.532429205 +0200 CEST        deployed        mysql-1.6.3                     5.7.28

### Deploy Nginx Ingress
`ansible-playbook -i inventories/s3group/dev/inventory playbooks/nginx-ingress.yml`
or
`make nginx`

        root@host:~# helm list -a
        NAME            NAMESPACE       REVISION        UPDATED                                         STATUS          CHART                           APP VERSION  
        custom-nginx    default         1               2020-04-22 16:49:51.015427202 +0200 CEST        deployed        nginx-ingress-1.36.3            0.30.0 

### Deploy Prometheus
`ansible-playbook -i inventories/s3group/dev/inventory playbooks/prometheus-operator.yml`

Initially deployment was failing due to [this](https://github.com/helm/charts/issues/17511) issue. Resolved by following [these](https://github.com/helm/charts/tree/master/stable/prometheus-operator#helm-fails-to-create-crds) steps. After CRDS had been deployed manually and Helm was triggered with `--skip-crds` flag, deployment failed due to Kubernetes cluster being unresponsive because of perfomance issues. 1-node cluster with 1 vCPU, 2GB RAM is not enough. 

        root@host:~# helm install my-release stable/prometheus-operator --skip-crds

        manifest_sorter.go:192: info: skipping unknown hook: "crd-install"
        manifest_sorter.go:192: info: skipping unknown hook: "crd-install"
        manifest_sorter.go:192: info: skipping unknown hook: "crd-install"
        manifest_sorter.go:192: info: skipping unknown hook: "crd-install"
        manifest_sorter.go:192: info: skipping unknown hook: "crd-install"
        manifest_sorter.go:192: info: skipping unknown hook: "crd-instal"
        Error: failed pre-install: warning: Hook pre-install prometheus-operator/templates/prometheus-operator/admission-webhooks/job-patch/job-createSecret.yaml failed: Internal error occurred: resource quota evaluates timeout

### Deploy Loki
`ansible-playbook -i inventories/s3group/dev/inventory playbooks/loki.yml.yml`


        root@host:~# helm list -a
        NAME            NAMESPACE       REVISION        UPDATED                                         STATUS          CHART                           APP VERSION
        custom-loki     default         1               2020-04-22 16:30:35.38723564 +0200 CEST         deployed        loki-stack-0.36.0               v1.4.1

## Misc 
- `make deps` fetches all roles specified in `requirements.yml`.
- `make clean` removes all roles specified in `requirements.yml`.

## Example execution

        (ansible) s3@host:~/task/kubernetes/ansible$ make mysql
        ansible-galaxy list | grep -v 'unknown version' | grep -o -P '(?<=-).*(?=,)' | xargs -I '{}' ansible-galaxy remove {}
        - successfully removed gantsign.helm
        ansible-galaxy install -r requirements.yml
        - downloading role 'helm', owned by gantsign
        - downloading role from https://github.com/gantsign/ansible_role_helm/archive/2.1.3.tar.gz
        - extracting gantsign.helm to /home/s3/task/kubernetes/ansible/roles/gantsign.helm
        - gantsign.helm (2.1.3) was installed successfully
        ansible-playbook -i "inventories/s3group/dev/inventory" playbooks/mysql.yml

        PLAY [Install MySQL using Helm into local Kuberenetes cluster] **************************************************************************************************************

        TASK [Gathering Facts] ******************************************************************************************************************************************************
        ok: [localhost]

        TASK [gantsign.helm : create download directory] ****************************************************************************************************************************
        ok: [localhost]

        TASK [gantsign.helm : download sha256sum] ***********************************************************************************************************************************
        ok: [localhost]

        TASK [gantsign.helm : read sha256sum] ***************************************************************************************************************************************
        ok: [localhost]

        TASK [gantsign.helm : download Helm] ****************************************************************************************************************************************
        ok: [localhost]

        TASK [gantsign.helm : check current version] ********************************************************************************************************************************
        ok: [localhost]

        TASK [gantsign.helm : current version] **************************************************************************************************************************************
        ok: [localhost] => {
        "msg": "v3.1.2"
        }

        TASK [gantsign.helm : remove existing installation] *************************************************************************************************************************
        skipping: [localhost]

        TASK [gantsign.helm : create the Helm installation dir] *********************************************************************************************************************
        ok: [localhost]

        TASK [gantsign.helm : install unarchive module dependencies (apt, yum, dnf, zypper)] ****************************************************************************************
        ok: [localhost]

        TASK [gantsign.helm : install Helm] *****************************************************************************************************************************************
        skipping: [localhost]

        TASK [gantsign.helm : create helm link] *************************************************************************************************************************************
        ok: [localhost]

        TASK [helm-chart-installer : assert that a kubernetes_namespace is defined] *************************************************************************************************
        ok: [localhost] => {
        "changed": false,
        "msg": "All assertions passed"
        }

        TASK [helm-chart-installer : assert that a chart_name is defined] ***********************************************************************************************************
        ok: [localhost] => {
        "changed": false,
        "msg": "All assertions passed"
        }

        TASK [helm-chart-installer : assert that a chart_name_from_repo is defined] *************************************************************************************************
        ok: [localhost] => {
        "changed": false,
        "msg": "All assertions passed"
        }

        TASK [helm-chart-installer : set_fact] **************************************************************************************************************************************
        ok: [localhost]

        TASK [helm-chart-installer : Check if stable/mysql has any configs to template] *********************************************************************************************
        ok: [localhost -> localhost]

        TASK [helm-chart-installer : Create temporary values file] ******************************************************************************************************************
        changed: [localhost]

        TASK [helm-chart-installer : Populate temporary values file] ****************************************************************************************************************
        changed: [localhost]

        TASK [helm-chart-installer : Deploy and activate custom-mysql] **************************************************************************************************************
        changed: [localhost]

        PLAY RECAP ******************************************************************************************************************************************************************
        localhost                  : ok=18   changed=3    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   