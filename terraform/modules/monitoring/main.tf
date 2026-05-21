provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

resource "datadog_monitor" "redmine-http" {
  name    = "Redmine HTTP Check"
  type    = "service check"
  message = "Redmine application is down on {{host.name}}"
  query   = "\"http.can_connect\".over(\"instance:redmine\").by(\"host\").last(4).count_by_status()"

  monitor_thresholds {
    warning  = 1
    critical = 2
  }

  tags = ["app:redmine", "env:production"]
}
