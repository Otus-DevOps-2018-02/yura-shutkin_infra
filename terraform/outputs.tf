output "app_external_ip_app_1" {
  value = "${google_compute_instance.app-1.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "app_external_ip_app_2" {
  value = "${google_compute_instance.app-2.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "reddit_app_http_balancer_ip" {
  value = "${google_compute_global_forwarding_rule.reddit-app-balancing-front.0.ip_address}"
}
