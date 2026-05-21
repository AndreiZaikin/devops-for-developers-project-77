variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "image_id" {
  type    = string
  default = "fd83m7rp3r4l12c2keph"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "datadog_api_key" {
  type      = string
  sensitive = true
}

variable "datadog_app_key" {
  type      = string
  sensitive = true
}
