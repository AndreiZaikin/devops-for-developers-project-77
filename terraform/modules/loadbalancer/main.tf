resource "yandex_alb_target_group" "redmine-tg" {
  name = "redmine-tg"

  dynamic "target" {
    for_each = var.target_ips
    content {
      subnet_id  = var.subnet_id
      ip_address = target.value
    }
  }
}

resource "yandex_alb_backend_group" "redmine-bg" {
  name = "redmine-bg"

  http_backend {
    name             = "redmine-backend"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_alb_target_group.redmine-tg.id]
    healthcheck {
      timeout             = "1s"
      interval            = "1s"
      healthy_threshold   = 1
      unhealthy_threshold = 1
      healthcheck_port    = 80
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "redmine-router" {
  name = "redmine-router"
}

resource "yandex_alb_virtual_host" "redmine-vhost" {
  name           = "redmine-vhost"
  http_router_id = yandex_alb_http_router.redmine-router.id
  authority      = ["*"]

  route {
    name = "redmine-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.redmine-bg.id
      }
    }
  }
}

resource "yandex_alb_load_balancer" "redmine-alb" {
  name       = "redmine-alb"
  network_id = var.network_id

  allocation_policy {
    location {
      zone_id   = var.zone
      subnet_id = var.subnet_id
    }
  }

  listener {
    name = "http-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.redmine-router.id
      }
    }
  }

  listener {
    name = "https-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [443]
    }
    tls {
      default_handler {
        certificate_ids = var.certificate_id != "" ? [var.certificate_id] : []
        http_handler {
          http_router_id = yandex_alb_http_router.redmine-router.id
        }
      }
    }
  }
}
