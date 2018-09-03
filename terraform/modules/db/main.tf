resource "google_compute_instance" "db" {
  name         = "reddit-db-${var.enviroment}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-db-${var.enviroment}"]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default-${var.enviroment}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  # правило применимо к инстансам с тегом ...
  target_tags = ["reddit-db-${var.enviroment}"]

  # порт будет доступен только для инстансов с тегом ...
  source_tags = ["reddit-app-${var.enviroment}"]
}
