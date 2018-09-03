#Firewall

resource "google_compute_firewall" "firewall_ssh" {
  name        = "default-allow-ssh-${var.enviroment}"
  network     = "default"
  description = "Allow SSH to all instances of ${var.enviroment}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${var.source_ranges}"]
}
