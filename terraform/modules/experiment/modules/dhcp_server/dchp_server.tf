
data "vsphere_virtual_machine" "template" {
   name          = var.template
   datacenter_id = var.config.datacenter
 }
resource "vsphere_virtual_machine" "vm" {
  name                        = var.virtual_machine_name
  resource_pool_id            = var.config.resource_pool
  datastore_id                = var.config.datastore
  host_system_id              = var.host
  folder                      = var.folder
     
  wait_for_guest_net_timeout = 0 // fix Error: timeout waiting for an available IP address
  wait_for_guest_ip_timeout  = 0 // fix Error: timeout waiting for an available IP address

  num_cpus = var.virtual_machine_num_cpus
  memory   = var.virtual_machine_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = var.network
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = var.virtual_machine_disk_label
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

   
  }

}
