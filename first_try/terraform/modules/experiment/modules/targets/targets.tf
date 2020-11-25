
data "vsphere_virtual_machine" "template" { //first create "vsphere_virtual_machine" instances from the templates
   for_each        = toset(var.template)
   name          = each.value
   datacenter_id = var.config.datacenter
 }
resource "vsphere_virtual_machine" "vm" {
 for_each                     = toset(var.template)
  name                        = "${each.key}_${var.name}"
  resource_pool_id            = var.config.resource_pool
  datastore_id                = var.config.datastore
  host_system_id              = var.host
  folder                      = var.folder
       
  wait_for_guest_net_timeout = var.network_waiter // fix Error: timeout waiting for an available IP address

  num_cpus = var.virtual_machine_num_cpus
  memory   = var.virtual_machine_memory
  guest_id = data.vsphere_virtual_machine.template[each.key].guest_id

  scsi_type = data.vsphere_virtual_machine.template[each.key].scsi_type

  network_interface {
    network_id   = var.inside_network.id
    adapter_type = data.vsphere_virtual_machine.template[each.key].network_interface_types[0]
  }
  dynamic "network_interface" {
    # Include this block only if var.public_network is
    # set to a non-null value.
    for_each = var.public_network[*]
    content {
      network_id = network_interface.value
      adapter_type = data.vsphere_virtual_machine.template[each.key].network_interface_types[1]
    }
  }
  //This “special power” of the splat operators is intended as a way to concisely adapt between a possibly-null single value and a list, because repetition based on lists is generally how Terraform generalizes situations where something is conditionally present.
  disk {
    label            = var.virtual_machine_disk_label
    size             = data.vsphere_virtual_machine.template[each.key].disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template[each.key].disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template[each.key].disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template[each.key].id
   
  }
   
}
