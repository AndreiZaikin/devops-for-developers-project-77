variable "name" {
  type = string
}

variable "zone" {
  type = string
}

variable "image_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2
}

variable "ssh_public_key" {
  type = string
}
