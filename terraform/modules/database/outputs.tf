output "fqdn" {
  value = yandex_mdb_postgresql_cluster.redmine-db.host.*.fqdn
}
