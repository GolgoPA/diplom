# Сеть и подсети.

resource "yandex_vpc_network" "diplom" {
  name = "diplom"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "web-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "web-2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}

resource "yandex_vpc_subnet" "subnet-3" {
  name           = "monitoring"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["192.168.12.0/24"]
}

resource "yandex_vpc_subnet" "subnet-4" {
  name           = "logs"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["192.168.13.0/24"]
}

resource "yandex_vpc_subnet" "subnet-5" {
  name           = "public"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["192.168.14.0/24"]
}

# Группы безопасности

resource "yandex_vpc_security_group" "webs" {
  name        = "webs"
  description = "description for my security group"
  network_id  = "${yandex_vpc_network.diplom.id}"

  ingress {
    protocol = "ANY"
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.11.0/24"]
    port = 80
  }
  
  egress {
    protocol = "ANY"
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.11.0/24"]
    port = 80
  }
}

resource "yandex_vpc_security_group" "grafana" {
  name        = "grafana"
  description = "description for my security group"
  network_id  = "${yandex_vpc_network.diplom.id}"

  ingress {
    protocol = "ANY"
    v4_cidr_blocks = ["192.168.14.0/24"]
    port = 3000
  }
  
  egress {
    protocol = "ANY"
    v4_cidr_blocks = ["192.168.14.0/24"]
    port = 3000
  }
}

resource "yandex_vpc_security_group" "kibana" {
  name        = "kibana"
  description = "description for my security group"
  network_id  = "${yandex_vpc_network.diplom.id}"

  ingress {
    protocol = "ANY"
    v4_cidr_blocks = ["192.168.14.0/24"]
    port = 5601
  }
  
  egress {
    protocol = "ANY"
    v4_cidr_blocks = ["192.168.14.0/24"]
    port = 5601
  }
}