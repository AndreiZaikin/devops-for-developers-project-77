output "web_sg_id" {
  value = yandex_vpc_security_group.web-sg.id
}

output "db_sg_id" {
  value = yandex_vpc_security_group.db-sg.id
}
