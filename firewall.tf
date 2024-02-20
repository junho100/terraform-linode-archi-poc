resource "linode_firewall" "bastion_host_firewall" {
  label = format(module.naming.result, "bh-firewall")

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.bastion_host.id]
}

resource "linode_firewall" "backend_firewall" {
  label = format(module.naming.result, "back-firewall")

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["${linode_instance.bastion_host.ip_address}/32"]
  }

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.backend.id]
}
