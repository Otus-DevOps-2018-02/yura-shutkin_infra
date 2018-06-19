###############################################################################
# backend services
###############################################################################

resource "google_compute_backend_service" "reddit-app-backend-service" {
  name                            = "reddit-app-backend-service"
  port_name                       = "reddit-app-http"
  protocol                        = "HTTP"
  timeout_sec                     = 10
  enable_cdn                      = false
  connection_draining_timeout_sec = 300

  backend {
    group = "${google_compute_instance_group_manager.reddit-app-group.instance_group}"
  }

  health_checks = ["${google_compute_http_health_check.reddit-app-health-check.self_link}"]
}

###############################################################################
# groups
###############################################################################

resource "google_compute_instance_group_manager" "reddit-app-group" {
  name               = "reddit-app-group"
  zone               = "${var.zone}"
  base_instance_name = "reddit-app"
  instance_template  = "${google_compute_instance_template.reddit-app-template.self_link}"

  target_size = "${var.instances_count}"

  named_port {
    name = "reddit-app-http"
    port = 9292
  }
}

###############################################################################
# proxy
###############################################################################

resource "google_compute_target_http_proxy" "reddit-app-proxy" {
  name    = "reddit-app-proxy"
  url_map = "${google_compute_url_map.reddit-app-url-map.self_link}"
}

###############################################################################
# url maps
###############################################################################

resource "google_compute_url_map" "reddit-app-url-map" {
  name = "reddit-app-url-map"

  default_service = "${google_compute_backend_service.reddit-app-backend-service.self_link}"
}

###############################################################################
# global forwarding rule
###############################################################################

resource "google_compute_global_forwarding_rule" "reddit-app-balancing-front" {
  name       = "reddit-app-balancing-front"
  target     = "${google_compute_target_http_proxy.reddit-app-proxy.self_link}"
  port_range = "80"
}

###############################################################################
# health checks
###############################################################################

resource "google_compute_http_health_check" "reddit-app-health-check" {
  name = "reddit-app-health-check"

  timeout_sec        = 5
  check_interval_sec = 5
  unhealthy_threshold = 5

  request_path = "/"
  port         = 9292
}

###############################################################################
# firewall rules
###############################################################################

resource "google_compute_firewall" "reddit-app-balancer-http-fw" {
  name    = "reddit-app-balancer-http-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
