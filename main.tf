# Создание сетки с публичным ip

resource "yandex_vpc_network" "network" {
  name = "docker-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name              = "docker-subnet"
  zone              = "ru-central1-a"
  network_id        = yandex_vpc_network.network.id
  v4_cidr_blocks    = ["192.168.10.0/24"]
}



# Создание диска и виртуальной машины
# создание диска
resource "yandex_compute_disk" "boot_disk" {
  name      = "boot-disk"
  zone      = "ru-central1-a"
  image_id   = "fd8ba9d5mfvlncknt2kd" # Ubuntu 22.04 LTS
  size      = 20
}

resource "yandex_compute_instance" "docker_host" {
  name                      = "docker-host"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"

  resources {
    cores =   var.def_numbers_of_cores  # 2
    memory =  var.def_ram_size          # 4
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot_disk.id
  }

  network_interface {
    subnet_id   = yandex_vpc_subnet.subnet.id
    nat         =  true # получить публичный ip
  }

  # подкинуть публичный ключ root
  metadata = {
    ssh-keys  = "ubuntu:${file(var.def_ssh_public_key)}" # пользака поменять отличного от root
    user-data = file("scripts/cloud-init.yaml")
  }
}

output "external_ip" {
  value = yandex_compute_instance.docker_host.network_interface[0].nat_ip_address
}