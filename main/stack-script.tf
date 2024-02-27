resource "linode_stackscript" "install_docker_nginx" {
  label       = "docker-nginx-ss"
  description = "install docker and run nginx"
  script      = file("./files/install-docker-nginx.sh")
  images      = ["linode/ubuntu22.04"]
}

resource "linode_stackscript" "install_docker_apache" {
  label       = "docker-apache-ss"
  description = "install docker and run apache"
  script      = file("./files/install-docker-apache.sh")
  images      = ["linode/ubuntu22.04"]
}

resource "linode_stackscript" "install_docker_mysql" {
  label       = format(module.naming.result, "db-stackscript")
  description = "install docker and run mysql"
  script = templatefile("./files/create-mysql.sh.tftpl", {
    password = var.database_password
  })
  images = ["linode/ubuntu22.04"]
}
