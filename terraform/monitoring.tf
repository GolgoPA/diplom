# Серверы мониторинга.

resource "yandex_compute_instance" "prometheus" {

  zone = "ru-central1-b"
  name = "prometheus"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8oshj0osht8svg6rfs"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-3.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta-prometheus.yaml")}"
  }
}

resource "yandex_compute_instance" "grafana" {

  zone = "ru-central1-b"
  name = "grafana"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 4
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
    user-data = "${file("./meta-grafana.yaml")}"
  }
}

output "prom" {
  value = yandex_compute_instance.prometheus.network_interface.0.ip_address
} 

output "grafana" {
  value = yandex_compute_instance.grafana.network_interface.0.ip_address
} 

output "grafana_pub" {
  value = yandex_compute_instance.grafana.network_interface.0.nat_ip_address
} 