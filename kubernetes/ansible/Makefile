ANSIBLE_DEFAULT_INVENTORY?="inventories/s3group/dev/inventory"

.PHONY: nginx
nginx: clean deps
	ansible-playbook -i $(ANSIBLE_DEFAULT_INVENTORY) playbooks/nginx-ingress.yml

.PHONY: mysql
mysql: clean deps
	ansible-playbook -i $(ANSIBLE_DEFAULT_INVENTORY) playbooks/mysql.yml

.PHONY: monitoring
monitoring: clean deps
	ansible-playbook -i $(ANSIBLE_DEFAULT_INVENTORY) playbooks/monitoring.yml

.PHONY: deps
deps:
	ansible-galaxy install -r requirements.yml

.PHONY: clean
clean:
	ansible-galaxy list | grep -v 'unknown version' | grep -o -P '(?<=-).*(?=,)' | xargs -I '{}' ansible-galaxy remove {}
