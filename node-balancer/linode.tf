resource "linode_instance" "bastion_host" {
  label     = format(module.naming.result, "bastion-host")
  image     = "linode/ubuntu22.04"
  region    = "jp-osa"
  type      = "g6-nanode-1"
  root_pass = var.instance_password

  interface {
    purpose = "public"
  }

  private_ip = true
}

resource "linode_instance" "nginx" {
  label     = format(module.naming.result, "nginx")
  image     = "linode/ubuntu22.04"
  region    = "jp-osa"
  type      = "g6-standard-1"
  root_pass = var.instance_password

  private_ip = true

  stackscript_id = linode_stackscript.install_docker_nginx.id
}

resource "linode_instance" "apache" {
  label     = format(module.naming.result, "apache")
  image     = "linode/ubuntu22.04"
  region    = "jp-osa"
  type      = "g6-standard-1"
  root_pass = var.instance_password

  private_ip = true

  stackscript_id = linode_stackscript.install_docker_apache.id
}

resource "linode_instance" "database" {
  label     = format(module.naming.result, "database")
  image     = "linode/ubuntu22.04"
  region    = "jp-osa"
  type      = "g6-standard-2"
  root_pass = var.instance_password

  interface {
    purpose = "public"
  }

  private_ip = true

  stackscript_id = linode_stackscript.install_docker_mysql.id
}
