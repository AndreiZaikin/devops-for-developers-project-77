variable "subnet_id" {
  type = string
}

variable "network_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "target_ips" {
  type = list(string)
}

variable "certificate_id" {
  type    = string
  default = ""
}
