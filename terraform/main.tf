provider "google" {
  version = "1.4.0"

  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  #определение загрузочного диска
  boot_disk {
    initialize_params {
     
      image = "${var.disk_image}"
    }
  }

  #определение сетевого интерфейса
  network_interface {
    # сеть,к которой присоеденить интерфейс
    network = "default"

    # использовать ephimeral IP для доступа в интернет
    access_config {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  ##SSH PROVISIONERS
  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file("${var.private_key_path}")}"
  }

  #PROVISIONERS
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  #название сети , в которой действует правило
  network = "default"

  # что разрешаем 
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  #откуда разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  #правила дл яинстансов с тегами
  target_tags = ["reddit-app"]
}
