terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  cloud_id = "b1gm7bp2grqbho73ke1l"
  folder_id = "b1g7l8ost873t9a9r3g3"
}