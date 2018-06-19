output "app_external_ip_app" {
  value = "${google_compute_instance.reddit-app.network_interface.0.access_config.0.assigned_nat_ip}"
}
