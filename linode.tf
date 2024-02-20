resource "linode_instance" "bastion_host" {
  label     = format(module.naming.result, "bastion-host")
  image     = "linode/ubuntu22.04"
  region    = "jp-osa"
  type      = "g6-nanode-1"
  root_pass = var.instance_password

  interface {
    purpose = "public"
  }

  interface {
    purpose   = "vpc"
    subnet_id = linode_vpc_subnet.public_subnet[0].id
  }

  private_ip = true
}

resource "linode_instance" "backend" {
  label     = format(module.naming.result, "backend")
  image     = "linode/ubuntu22.04"
  region    = "jp-osa"
  type      = "g6-nanode-1"
  root_pass = var.instance_password

  interface {
    purpose   = "vpc"
    subnet_id = linode_vpc_subnet.backend_subnet[0].id
    ipv4 {
      nat_1_1 = "any"
    }
  }

  private_ip = true
}
