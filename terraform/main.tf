provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "app-1" {
  name         = "reddit-app-1"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  tags = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  // Local SSD disk
  // scratch_disk {
  // }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}"
  }

  // metadata_startup_script = "echo hi > /test.txt"


  // service_account {
  //   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  // }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_instance" "app-2" {
  name         = "reddit-app-2"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  tags = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  // Local SSD disk
  // scratch_disk {
  // }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}"
  }

  // metadata_startup_script = "echo hi > /test.txt"


  // service_account {
  //   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  // }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
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