module "vpc_develop" {
  source      = "./vpc-local"
  env_name    = var.env_name
  subnet_zone = var.default_zone
  cidr        = var.default_cidr
}

resource "yandex_compute_instance" "sonarqube" {
  count       = 1
  name        = "${var.sonarqube_name}-0${count.index+1}"

  resources {
    cores         = var.vm_sonarqube_resources.cores
    memory        = var.vm_sonarqube_resources.memory
    core_fraction = var.vm_sonarqube_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = module.vpc_develop.subnet_ids
    nat       = true
  }

  metadata = {
    ssh-keys  = local.ssh-key
    serial-port-enable = 1
  }
}

resource "yandex_compute_instance" "nexus" {
  count       = 1
  name        = "${var.nexus_name}-0${count.index+1}"

  resources {
    cores         = var.vm_nexus_resources.cores
    memory        = var.vm_nexus_resources.memory
    core_fraction = var.vm_nexus_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = module.vpc_develop.subnet_ids
    nat       = true
  }

  metadata = {
    ssh-keys  = local.ssh-key
    serial-port-enable = 1
  }
}
