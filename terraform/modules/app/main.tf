resource "google_compute_instance" "app" {
  name         = "reddit-app-${var.enviroment}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app-${var.enviroment}"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip-${var.enviroment}"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default-${var.enviroment}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app-${var.enviroment}"]
}

# Provision instance

resource "null_resource" "app" {
  count = "${var.app_provision ? 1 : 0}" #if app_provision true, enable this resource

  connection {
    type        = "ssh"
    host        = "${google_compute_address.app_ip.address}"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "${path.module}/files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    inline = [
      "echo DATABASE_URL=${var.db_address} | sudo tee --append /etc/default/puma",
    ]
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}
