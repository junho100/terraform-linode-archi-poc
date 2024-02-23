resource "linode_vpc" "vpc" {
  label       = format(module.naming.result, "vpc")
  region      = "jp-osa"
  description = "vpc"
}
