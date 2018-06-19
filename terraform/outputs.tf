output "app_external_ip_app" {
  value = "${module.app.app_external_ip_app}"
}

# output "reddit_app_http_balancer_ip" {
#   value = "${google_compute_global_forwarding_rule.reddit-app-balancing-front.0.ip_address}"
# }
