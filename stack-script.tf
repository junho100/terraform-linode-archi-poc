resource "linode_stackscript" "install_docker_mysql" {
  label       = format(module.naming.result, "db-stackscript")
  description = "install docker and run mysql"
  script = templatefile("./files/create-mysql.sh.tftpl", {
    password = var.database_password
  })
  images = ["linode/ubuntu22.04"]
}
