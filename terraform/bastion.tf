# Бастион-хост

resource "yandex_compute_instance" "bastion" {

  zone = "ru-central1-b"
  name = "bastion"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8oshj0osht8svg6rfs"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-5.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta-bastion.yaml")}"
  }
}

output "Bastion_host_pub" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
} 