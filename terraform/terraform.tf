provider "vsphere" {
  
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  version         =var.vsphere_version
  # If you have a self-signed cert
  allow_unverified_ssl = var.vsphere_unverified_ssl
  #solve ServerFaultCode: Request version 'urn:pbm/' and namespace 'urn:pbm' are not supported
}
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}
data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "out_attack" {
  name          = var.vsphere_out_attack
  datacenter_id = data.vsphere_datacenter.dc.id
}
//currently  we have only one external network 
# data "vsphere_network" "out_control" {
#   name          = var.vsphere_out_control
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

module "name" {
  source = "./modules/experiment"
  config = local.config
  experiment = local.experiment_0
  
}
# module "remote_ex" {
#   //depends_on = [ module.name ]
#   source = "./modules/remote"
#   config = local.config
#   experiment_out = module.name.ip_list
  
# }

