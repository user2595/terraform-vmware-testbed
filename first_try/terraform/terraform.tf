provider "vsphere" {
  //version ="1.15.0"
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

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




data "vsphere_host" "host" {
  name          = var.vsphere_host_name 
  datacenter_id = data.vsphere_datacenter.dc.id
}

# data "vsphere_network" "public" {
#   name          = var.vsphere_network_public
#   datacenter_id = data.vsphere_datacenter.dc.id
# }



module "experiment" {
  source = "./modules/experiment"
  config = local.config
  name = var.experiment_0
  host = local.host
  templates = local.templates
  network_public = local.network_public           
}
