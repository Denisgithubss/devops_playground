terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_vpc_network" "lab_net" {
  name = "devops-lab-network"
}

resource "yandex_vpc_subnet" "lab_subnet" {
  name           = "devops-lab-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.lab_net.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_security_group" "lab_sg" {
  name        = "devops-lab-sg"
  network_id  = yandex_vpc_network.lab_net.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "K3s API"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 6443
  }

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}
