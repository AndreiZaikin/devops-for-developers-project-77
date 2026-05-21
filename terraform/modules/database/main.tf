resource "yandex_mdb_postgresql_cluster" "redmine-db" {
  name               = "redmine-db"
  environment        = "PRODUCTION"
  network_id         = var.network_id
  security_group_ids = var.security_group_ids

  config {
    version = "15"
    resources {
      resource_preset_id = "b2.medium"
      disk_type_id       = "network-hdd"
      disk_size          = 10
    }
  }

  host {
    zone      = var.zone
    subnet_id = var.subnet_id
  }
}

resource "yandex_mdb_postgresql_database" "redmine" {
  cluster_id = yandex_mdb_postgresql_cluster.redmine-db.id
  name       = "redmine"
  owner      = "redmine"

  depends_on = [yandex_mdb_postgresql_user.redmine]
}

resource "yandex_mdb_postgresql_user" "redmine" {
  cluster_id = yandex_mdb_postgresql_cluster.redmine-db.id
  name       = "redmine"
  password   = var.db_password
}
