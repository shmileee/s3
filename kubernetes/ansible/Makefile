ANSIBLE_ROLES_PATH?="roles"
ANSIBLE_DEFAULT_INVENTORY?="inventories/s3group/dev/inventory"

.PHONY: deploy
deploy: clean deps
	ansible-playbook -i $(ANSIBLE_DEFAULT_INVENTORY) playbooks/site.yml

.PHONY: deps
deps:
	ansible-galaxy install -r requirements.yml

.PHONY: clean
clean:
	find $(ANSIBLE_ROLES_PATH) -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | xargs -I '{}' ansible-galaxy remove {}

