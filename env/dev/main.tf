module "dev_infra" {
  source = "../../modules/networking_app"

  #environment specific variables
  env = "dev"
  project_name = "multiterraform"
  location = "southafricanorth"
  vnet_cidr = "10.0.1.0/24"
  vm_size = var.vm_size
  admin_user = "devadmin"

}

