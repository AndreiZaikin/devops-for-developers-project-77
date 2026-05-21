terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.87"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = ">= 3.0"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = var.zone
}
