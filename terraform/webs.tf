# Web-Серверы, целевые группы, роутер, балансировщик

resource "yandex_compute_instance" "server-1" {

  zone = "ru-central1-a"
  name = "server-1"

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
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}

resource "yandex_compute_instance" "server-2" {

  zone = "ru-central1-b"
  name = "server-2"

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
    subnet_id = yandex_vpc_subnet.subnet-2.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}

resource "yandex_alb_target_group" "web" {
  name = "web"

  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    ip_address   = yandex_compute_instance.server-1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.subnet-2.id
    ip_address   = yandex_compute_instance.server-2.network_interface.0.ip_address
  }
}

resource "yandex_alb_backend_group" "web-servers" {
  http_backend {
    name = "web-servers"
    target_group_ids = ["${yandex_alb_target_group.web.id}"]
    port = 80
    healthcheck {
      timeout = "1s"
      interval = "1s"
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "router" {
  name = "web-servers-router"
}

resource "yandex_alb_virtual_host" "virtual-host" {
  name = "web-servers-router-virtual-host"
  http_router_id = yandex_alb_http_router.router.id
  route {
    name = "my-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.web-servers.id
      }
    }
  }
}

resource "yandex_alb_load_balancer" "app-lb" {
  name = "app-lb"
  network_id = yandex_vpc_network.diplom.id

  allocation_policy {
    location {
      zone_id = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.subnet-5.id
    }
  }
  listener {
    name = "listener-1"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ "80" ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.router.id
      }
    }
  }
}

output "web-1" {
  value = yandex_compute_instance.server-1.network_interface.0.ip_address
} 

output "web-2" {
  value = yandex_compute_instance.server-2.network_interface.0.ip_address
} 

output "load_balancer_pub" {
  value = yandex_alb_load_balancer.app-lb.listener[0].endpoint[0].address[0].external_ipv4_address
} 