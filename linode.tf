resource "linode_instance" "nginx" {
  label     = format(module.naming.result, "linode-1")
  image     = "linode/ubuntu22.04"
  region    = "jp-osa"
  type      = "g6-standard-1"
  root_pass = var.instance_password

  private_ip = true

  stackscript_id = linode_stackscript.install_docker_nginx.id
}

resource "linode_instance" "apache" {
  label     = format(module.naming.result, "linode-2")
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

  private_ip = true

  stackscript_id = linode_stackscript.install_docker_mysql.id
}
