output "public_ip" {
  description = "Public floating IP address assigned to the web server."
  value       = openstack_networking_floatingip_v2.web.address
}

output "website_url" {
  description = "Public HTTP URL of the web server."
  value       = "http://${openstack_networking_floatingip_v2.web.address}"
}