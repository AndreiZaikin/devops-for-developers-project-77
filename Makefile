.PHONY: init plan apply destroy output clean inventory install-roles deploy fmt setup-docker setup-monitoring

init:
	cd terraform && terraform init

plan:
	cd terraform && terraform plan

apply:
	cd terraform && terraform apply

destroy:
	cd terraform && terraform destroy

output:
	cd terraform && terraform output

clean:
	cd terraform && rm -rf .terraform .terraform.lock.hcl

inventory:
	cd terraform && terraform output -raw vm-1-external-ip > /dev/null 2>&1 || (echo "Run terraform apply first" && exit 1)
	cd terraform && terraform apply -target=local_file.inventory -auto-approve

install-roles:
	cd ansible && ansible-galaxy install -r requirements.yml

deploy:
	echo "$$ANSIBLE_VAULT_PASSWORD" | ansible-playbook -i inventory.ini ansible/playbook.yml --tags deploy --vault-password-file /dev/stdin

fmt:
	cd terraform && terraform fmt -recursive

setup-docker:
	echo "$$ANSIBLE_VAULT_PASSWORD" | ansible-playbook -i inventory.ini ansible/playbook.yml --tags docker --vault-password-file /dev/stdin

setup-monitoring:
	echo "$$ANSIBLE_VAULT_PASSWORD" | ansible-playbook -i inventory.ini ansible/playbook.yml --tags monitoring --vault-password-file /dev/stdin
