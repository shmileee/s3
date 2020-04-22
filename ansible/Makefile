ANSIBLE_DEFAULT_INVENTORY?="inventories/s3group/dev/inventory"

.PHONY: deploy
deploy: clean deps
	ansible-playbook -i $(ANSIBLE_DEFAULT_INVENTORY) playbooks/site.yml

.PHONY: deps
deps:
	ansible-galaxy install -r requirements.yml

.PHONY: clean
clean:
	ansible-galaxy list | grep -v 'unknown version' | grep -o -P '(?<=-).*(?=,)' | xargs -I '{}' ansible-galaxy remove {}


