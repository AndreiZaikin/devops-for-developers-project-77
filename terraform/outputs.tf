output "external_ip_vms" {
  value = [
    module.vm-1.external_ip,
    module.vm-2.external_ip
  ]
}

output "internal_ip_vms" {
  value = [
    module.vm-1.internal_ip,
    module.vm-2.internal_ip
  ]
}

output "lb_ip" {
  value = module.loadbalancer.external_ip
}

output "db_host" {
  value = module.database.fqdn
}

output "domain" {
  value = "https://hexlet-deploy-project.ru"
}
