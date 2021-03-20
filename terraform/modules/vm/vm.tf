data "vsphere_host" "host" {
  name          = var.vsphere_host_name 
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "public" {
  name          = var.vsphere_network_public
  datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_virtual_machine" "template_kalivm" {
   name          = var.vsphere_template_kalivm 
   datacenter_id = data.vsphere_datacenter.dc.id
 }
data "vsphere_virtual_machine" "template" {
   name          = var.vsphere_template 
   datacenter_id = data.vsphere_datacenter.dc.id
 }

# data "vsphere_virtual_machine" "template_DHCP" {
#    name          = var.vsphere_template_DHCP
#    datacenter_id = data.vsphere_datacenter.dc.id
#  }


resource "vsphere_virtual_machine" "vm_1" {
  name                        = "kali"
  resource_pool_id            = data.vsphere_resource_pool.pool.id
  datastore_id                = data.vsphere_datastore.datastore.id
  host_system_id              = data.vsphere_host.host.id
  folder                      = vsphere_folder.folder.path

  wait_for_guest_net_timeout = 0 // fix Error: timeout waiting for an available IP address
  wait_for_guest_ip_timeout  = 0 // fix Error: timeout waiting for an available IP address


  num_cpus = var.vsphere_virtual_machine_num_cpus
  memory   = var.vsphere_virtual_machine_memory
  guest_id = data.vsphere_virtual_machine.template_kalivm.guest_id

  scsi_type = data.vsphere_virtual_machine.template_kalivm.scsi_type

  network_interface {
    network_id   = data.vsphere_network.public.id
    adapter_type = data.vsphere_virtual_machine.template_kalivm.network_interface_types[0]
  }
  network_interface {
    network_id   = data.vsphere_network.inside_network.id
    adapter_type = data.vsphere_virtual_machine.template_kalivm.network_interface_types[1]
  }
  disk {
    label            = "kalid"
    size             = data.vsphere_virtual_machine.template_kalivm.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template_kalivm.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template_kalivm.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template_kalivm.id
  }
   
}

# Finally, we're outputting the IP address of the new VM

output "my_ip_address" {
 value = vsphere_virtual_machine.vm_1.default_ip_address
}



resource "vsphere_virtual_machine" "vm_3" {
  name                        = "test_3"
  resource_pool_id            = data.vsphere_resource_pool.pool.id
  datastore_id                = data.vsphere_datastore.datastore.id
  host_system_id              = data.vsphere_host.host.id
  //folder                     = vsphere_folder.folder.path


  wait_for_guest_net_timeout = 0 // fix Error: timeout waiting for an available IP address
  wait_for_guest_ip_timeout  = 0 // fix Error: timeout waiting for an available IP address


  num_cpus = var.vsphere_virtual_machine_num_cpus
  memory   = var.vsphere_virtual_machine_memory 
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.inside_network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = var.vsphere_virtual_machine_disk_label
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

   
  }
   
}
