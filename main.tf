
provider "vsphere" {
  version ="1.15.0"
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

data "vsphere_network" "public" {
  name          = var.vsphere_network_public
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "privat" {
  name          = var.vsphere_network_privat
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template_DHCP" {
   name          = var.vsphere_template_DHCP
   datacenter_id = "${data.vsphere_datacenter.dc.id}"
 }



resource "vsphere_host_virtual_switch" "switch" {
  name           = var.vsphere_host_virtual_switch_name
  host_system_id = "${data.vsphere_host.host.id}"

  network_adapters = []

  active_nics  = []
  standby_nics = []
}
resource "vsphere_host_port_group" "pg" {
  name                = var.vsphere_host_port_group_name
  host_system_id      = "${data.vsphere_host.host.id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.switch.name}"
}



//https://github.com/hashicorp/terraform-provider-vsphere/issues/554


resource "null_resource" "inside_network" {
  triggers = {
    name = var.vsphere_host_port_group_name
    ids  = vsphere_host_port_group.pg.id
  }
  provisioner "local-exec" {
    command = "sleep 5"
  }
}

data "vsphere_network" "inside_network" {
  name          = null_resource.inside_network.triggers.name
  datacenter_id = data.vsphere_datacenter.dc.id
}

##########################################################################
############ creat new VM from Templet ###################################
##########################################################################

resource "vsphere_virtual_machine" "vm" {
  name             = var.vsphere_virtual_machine_name
  resource_pool_id            = "${data.vsphere_resource_pool.pool.id}"
  datastore_id                = "${data.vsphere_datastore.datastore.id}"
  host_system_id              = "${data.vsphere_host.host.id}"

  num_cpus = var.vsphere_virtual_machine_num_cpus
  memory   = var.vsphere_virtual_machine_memory
  guest_id = "${data.vsphere_virtual_machine.template_DHCP.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template_DHCP.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.privat.id}"
    adapter_type = "${data.vsphere_virtual_machine.template_DHCP.network_interface_types[0]}"
  }
  disk {
    label            = var.vsphere_virtual_machine_disk_label
    size             = "${data.vsphere_virtual_machine.template_DHCP.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template_DHCP.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template_DHCP.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template_DHCP.id}"

   
  }
}

