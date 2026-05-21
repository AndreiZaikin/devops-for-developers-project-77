module "network" {
  source = "./modules/network"
  zone   = var.zone
}

module "vm-1" {
  source             = "./modules/compute"
  name               = "web-server-1"
  zone               = var.zone
  image_id           = var.image_id
  subnet_id          = module.network.subnet_id
  security_group_ids = [module.security.web_sg_id]
  cores              = 2
  memory             = 2
  ssh_public_key     = file("~/.ssh/yc_key.pub")
}

module "vm-2" {
  source             = "./modules/compute"
  name               = "web-server-2"
  zone               = var.zone
  image_id           = var.image_id
  subnet_id          = module.network.subnet_id
  security_group_ids = [module.security.web_sg_id]
  cores              = 2
  memory             = 2
  ssh_public_key     = file("~/.ssh/yc_key.pub")
}

module "security" {
  source     = "./modules/security"
  network_id = module.network.network_id
}

module "database" {
  source             = "./modules/database"
  zone               = var.zone
  network_id         = module.network.network_id
  subnet_id          = module.network.subnet_id
  security_group_ids = [module.security.db_sg_id]
  db_password        = var.db_password
}

module "dns" {
  source = "./modules/dns"
  domain = "hexlet-deploy-project.ru"
  alb_ip = module.loadbalancer.external_ip
}

module "loadbalancer" {
  source         = "./modules/loadbalancer"
  subnet_id      = module.network.subnet_id
  network_id     = module.network.network_id
  zone           = var.zone
  target_ips     = [module.vm-1.internal_ip, module.vm-2.internal_ip]
  certificate_id = module.dns.certificate_id
}

resource "local_file" "inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl", {
    vm-1-external-ip = module.vm-1.external_ip
    vm-1-internal-ip = module.vm-1.internal_ip
    vm-2-external-ip = module.vm-2.external_ip
    vm-2-internal-ip = module.vm-2.internal_ip
    db_host          = module.database.fqdn[0]
  })
  filename = "${path.module}/../inventory.ini"
}

module "monitoring" {
  source          = "./modules/monitoring"
  datadog_api_key = var.datadog_api_key
  datadog_app_key = var.datadog_app_key
  domain          = "hexlet-deploy-project.ru"
}
