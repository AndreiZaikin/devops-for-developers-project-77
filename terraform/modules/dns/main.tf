resource "yandex_dns_zone" "main" {
  name   = "hexlet-zone"
  zone   = "${var.domain}."
  public = true
}

resource "yandex_dns_recordset" "a-record" {
  zone_id = yandex_dns_zone.main.id
  name    = "${var.domain}."
  type    = "A"
  ttl     = 300
  data    = [var.alb_ip]
}

resource "yandex_cm_certificate" "le-cert" {
  name    = "hexlet-cert"
  domains = [var.domain]

  managed {
    challenge_type = "DNS_CNAME"
  }
}

resource "yandex_dns_recordset" "validation" {
  zone_id = yandex_dns_zone.main.id
  name    = yandex_cm_certificate.le-cert.challenges[0].dns_name
  type    = yandex_cm_certificate.le-cert.challenges[0].dns_type
  data    = [yandex_cm_certificate.le-cert.challenges[0].dns_value]
  ttl     = 60
}

data "yandex_cm_certificate" "validated" {
  depends_on      = [yandex_dns_recordset.validation]
  certificate_id  = yandex_cm_certificate.le-cert.id
  wait_validation = true
}
