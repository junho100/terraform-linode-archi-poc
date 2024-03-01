resource "linode_firewall" "backend_backend_firewall" {
  label = format(module.naming.result, "backend-fw")

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
  }

  inbound {
    label    = "allow-nb-traffic"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "3000"
    ipv4     = ["192.168.255.0/24"]
  }

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.nginx.id, linode_instance.apache.id]
}

resource "linode_firewall" "database_firewall" {
  label = format(module.naming.result, "database-fw")

  inbound {
    label    = "allow-db"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "3306"
    ipv4     = ["${var.vpn_ip_address}/32"]
  }

  inbound {
    label    = "allow-db-backend"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "3306"
    ipv4     = ["${linode_instance.nginx.ip_address}/32", "${linode_instance.apache.ip_address}/32"]

  }

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.database.id]
}

resource "linode_firewall" "nb_fw" {
  label = format(module.naming.result, "nb-fw")

  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  nodebalancers = [linode_nodebalancer.backend_nb.id]
}
