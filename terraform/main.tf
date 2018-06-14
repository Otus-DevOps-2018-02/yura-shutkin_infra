provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance_template" "reddit-app-template" {
  name         = "reddit-app-template"
  machine_type = "g1-small"

  tags = ["reddit-app"]

  disk {
    source_image = "${var.disk_image}"
    boot         = true
    auto_delete  = true
  }

  network_interface {
    network = "default"
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["reddit-app"]
}
