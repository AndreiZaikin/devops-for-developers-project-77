output "external_ip" {
  value = yandex_alb_load_balancer.redmine-alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}
