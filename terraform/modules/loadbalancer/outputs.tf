output "external_ip" {
  value = yandex_alb_load_balancer.redmine-alb.listener[*].endpoint[*].address[*].external_ipv4_address[*].address
}
