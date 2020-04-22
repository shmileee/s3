# Ansible

A collection of Ansible roles that configures user, installs git, docker and kubernetes on Linux.

## Requirements

Requires pipenv, ansible >= 2.9.7. 
Install dependencies:

    sudo apt install pipenv
    pipenv install

## Role Variables

For default variables used please refer to roles fetched via ansible-galaxy documentation. Custom variables are under `inventories/<project>/<environment>/group_vars`):

    ansible_python_interpreter: /usr/bin/python3

    user_groups: []
    user_name: "s3-deployer"
    user_shell: "/bin/bash"
    user_generate_ssh_key: False
    user_local_ssh_key_path: "~/.ssh/id_rsa.pub"
    user_enable_passwordless_sudo: True

    kubernetes_allow_pods_on_master: True

## Deployment

After requirements are met, deployment can be trigger using default `make` target. 
- `make clean` removes all roles installed from Ansible Galaxy. 
- `make deps` fetches all roles specified in `requirements.yml`.

## Example execution

    s3@host:~/task/ansible$ make
    find "roles" -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | xargs -I '{}' ansible-galaxy remove {}
    ansible-galaxy install -r requirements.yml
    - downloading role 'user', owned by nickjj
    - downloading role from https://github.com/nickjj/ansible-user/archive/v0.4.0.tar.gz
    - extracting nickjj.user to /home/s3/task/ansible/roles/nickjj.user
    - nickjj.user (v0.4.0) was installed successfully
    - downloading role 'git', owned by geerlingguy
    - downloading role from https://github.com/geerlingguy/ansible-role-git/archive/3.0.0.tar.gz
    - extracting geerlingguy.git to /home/s3/task/ansible/roles/geerlingguy.git
    - geerlingguy.git (3.0.0) was installed successfully
    - downloading role 'pip', owned by geerlingguy
    - downloading role from https://github.com/geerlingguy/ansible-role-pip/archive/1.3.0.tar.gz
    - extracting geerlingguy.pip to /home/s3/task/ansible/roles/geerlingguy.pip
    - geerlingguy.pip (1.3.0) was installed successfully
    - downloading role 'docker', owned by geerlingguy
    - downloading role from https://github.com/geerlingguy/ansible-role-docker/archive/2.7.0.tar.gz
    - extracting geerlingguy.docker to /home/s3/task/ansible/roles/geerlingguy.docker
    - geerlingguy.docker (2.7.0) was installed successfully
    - downloading role 'kubernetes', owned by geerlingguy
    - downloading role from https://github.com/geerlingguy/ansible-role-kubernetes/archive/4.1.0.tar.gz
    - extracting geerlingguy.kubernetes to /home/s3/task/ansible/roles/geerlingguy.kubernetes
    - geerlingguy.kubernetes (4.1.0) was installed successfully
    ansible-playbook -i "inventories/s3group/dev/inventory" playbooks/site.yml

    PLAY [Configure server(s)] **************************************************************************************************************************************************

    TASK [Gathering Facts] ******************************************************************************************************************************************************
    ok: [localhost]

    TASK [nickjj.user : Create user group(s)] ***********************************************************************************************************************************

    TASK [nickjj.user : Create user] ********************************************************************************************************************************************
    ok: [localhost]

    TASK [nickjj.user : Enable sudoers.d] ***************************************************************************************************************************************
    ok: [localhost]

    TASK [nickjj.user : Enable passwordless sudo] *******************************************************************************************************************************
    ok: [localhost]

    TASK [nickjj.user : Set authorized_key to allow SSH key based logins] *******************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.git : Ensure git is installed (RedHat).] ******************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.git : Update apt cache (Debian).] *************************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.git : Ensure git is installed (Debian).] ******************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.git : Include OS-specific variables (RedHat).] ************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.git : Include OS-specific variables (Fedora).] ************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.git : Include OS-specific variables (Debian).] ************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.git : Define git_install_from_source_dependencies.] *******************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.git : Ensure git's dependencies are installed.] ***********************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.git : Get installed version.] *****************************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.git : Force git install if the version numbers do not match.] *********************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.git : Download git.] **************************************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.git : Expand git archive.] ********************************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.git : Build git.] *****************************************************************************************************************************************
    skipping: [localhost] => (item=all) 
    skipping: [localhost] => (item=install) 

    TASK [geerlingguy.docker : include_tasks] ***********************************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.docker : include_tasks] ***********************************************************************************************************************************
    included: /home/s3/task/ansible/roles/geerlingguy.docker/tasks/setup-Debian.yml for localhost

    TASK [geerlingguy.docker : Ensure old versions of Docker are not installed.] ************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.docker : Ensure dependencies are installed.] **************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.docker : Add Docker apt key.] *****************************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.docker : Ensure curl is present (on older systems without SNI).] ******************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.docker : Add Docker apt key (alternative for older systems without SNI).] *********************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.docker : Add Docker repository.] **************************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.docker : Install Docker.] *********************************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.docker : Ensure Docker is started and enabled at boot.] ***************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.docker : include_tasks] ***********************************************************************************************************************************
    included: /home/s3/task/ansible/roles/geerlingguy.docker/tasks/docker-compose.yml for localhost

    TASK [geerlingguy.docker : Check current docker-compose version.] ***********************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.docker : Delete existing docker-compose version if it's different.] ***************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.docker : Install Docker Compose (if configured).] *********************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.docker : include_tasks] ***********************************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.kubernetes : Include OS-specific variables.] **************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : include_tasks] *******************************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.kubernetes : include_tasks] *******************************************************************************************************************************
    included: /home/s3/task/ansible/roles/geerlingguy.kubernetes/tasks/setup-Debian.yml for localhost

    TASK [geerlingguy.kubernetes : Ensure dependencies are installed.] **********************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Add Kubernetes apt key.] *********************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Add Kubernetes repository.] ******************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Add Kubernetes apt preferences file to pin a version.] ***************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Ensure dependencies are installed.] **********************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Install Kubernetes packages.] ****************************************************************************************************************
    ok: [localhost] => (item={u'state': u'present', u'name': u'kubelet'})
    ok: [localhost] => (item={u'state': u'present', u'name': u'kubectl'})
    ok: [localhost] => (item={u'state': u'present', u'name': u'kubeadm'})
    ok: [localhost] => (item={u'state': u'present', u'name': u'kubernetes-cni'})

    TASK [geerlingguy.kubernetes : include_tasks] *******************************************************************************************************************************
    included: /home/s3/task/ansible/roles/geerlingguy.kubernetes/tasks/kubelet-setup.yml for localhost

    TASK [geerlingguy.kubernetes : Check for existence of kubelet environment file.] ********************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Set facts for KUBELET_EXTRA_ARGS task if environment file exists.] ***************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.kubernetes : Set facts for KUBELET_EXTRA_ARGS task if environment file doesn't exist.] ********************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Configure KUBELET_EXTRA_ARGS.] ***************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Reload systemd unit if args were changed.] ***************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.kubernetes : Ensure kubelet is started and enabled at boot.] **********************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Check if Kubernetes has already been initialized.] *******************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : include_tasks] *******************************************************************************************************************************
    included: /home/s3/task/ansible/roles/geerlingguy.kubernetes/tasks/master-setup.yml for localhost

    TASK [geerlingguy.kubernetes : Initialize Kubernetes master with kubeadm init.] *********************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.kubernetes : Print the init output to screen.] ************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.kubernetes : Ensure .kube directory exists.] **************************************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Symlink the kubectl admin.conf to ~/.kube/conf.] *********************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Configure Flannel networking.] ***************************************************************************************************************
    ok: [localhost] => (item=kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml)
    ok: [localhost] => (item=kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml)

    TASK [geerlingguy.kubernetes : Configure Calico networking.] ****************************************************************************************************************
    skipping: [localhost] => (item=kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml) 

    TASK [geerlingguy.kubernetes : Get Kubernetes version for Weave installation.] **********************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.kubernetes : Configure Weave networking.] *****************************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.kubernetes : Allow pods on master node (if configured).] **************************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.kubernetes : Check if Kubernetes Dashboard UI service already exists.] ************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Enable the Kubernetes Web Dashboard UI (if configured).] *************************************************************************************
    skipping: [localhost]

    TASK [geerlingguy.kubernetes : Get the kubeadm join command from the Kubernetes master.] ************************************************************************************
    ok: [localhost]

    TASK [geerlingguy.kubernetes : Set the kubeadm join command globally.] ******************************************************************************************************
    ok: [localhost -> localhost] => (item=localhost)

    TASK [geerlingguy.kubernetes : include_tasks] *******************************************************************************************************************************
    skipping: [localhost]

    PLAY RECAP ******************************************************************************************************************************************************************
    localhost                  : ok=38   changed=0    unreachable=0    failed=0   