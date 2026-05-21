resource "yandex_vpc_security_group" "web-sg" {
  name       = "web-sg"
  network_id = var.network_id

  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "db-sg" {
  name       = "db-sg"
  network_id = var.network_id

  ingress {
    protocol       = "TCP"
    port           = 5432
    v4_cidr_blocks = ["192.168.10.0/24"]
  }
}
