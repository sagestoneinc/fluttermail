provider "digitalocean" {
  token = var.do_token
}

module "cluster" {
  source = "terraform-digitalocean-modules/kubernetes/do"
  name   = "sagestone-prod"
  region = "sgp1"
  node_pools = [{
    name       = "api-pool"
    size       = "g-4vcpu-16gb"
    count      = 3
    auto_scale = true
  }]
}
