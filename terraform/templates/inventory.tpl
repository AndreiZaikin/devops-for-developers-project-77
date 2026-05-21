[webservers]
web-server-1 ansible_host=${vm-1-external-ip} internal_ip=${vm-1-internal-ip}
web-server-2 ansible_host=${vm-2-external-ip} internal_ip=${vm-2-internal-ip}

[all:vars]
ansible_user=ubuntu
redmine_db_host=${db_host}
redmine_db_port=5432
