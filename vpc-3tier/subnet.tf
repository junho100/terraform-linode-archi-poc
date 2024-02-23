locals {
  public_cidr_blocks   = ["10.0.1.0/24"]
  backend_cidr_blocks  = ["10.0.2.0/24"]
  database_cidr_blocks = ["10.0.3.0/24"]
}

resource "linode_vpc_subnet" "public_subnet" {
  count  = length(local.public_cidr_blocks)
  vpc_id = linode_vpc.vpc.id
  label  = format(module.naming.result, "public-subnet-${count.index + 1}")
  ipv4   = local.public_cidr_blocks[count.index]
}

resource "linode_vpc_subnet" "backend_subnet" {
  count  = length(local.backend_cidr_blocks)
  vpc_id = linode_vpc.vpc.id
  label  = format(module.naming.result, "backend-subnet-${count.index + 1}")
  ipv4   = local.backend_cidr_blocks[count.index]
}

resource "linode_vpc_subnet" "database_subnet" {
  count  = length(local.database_cidr_blocks)
  vpc_id = linode_vpc.vpc.id
  label  = format(module.naming.result, "database-subnet-${count.index + 1}")
  ipv4   = local.database_cidr_blocks[count.index]
}
