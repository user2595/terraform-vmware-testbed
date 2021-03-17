
data "vsphere_virtual_machine" "template" { //first create "vsphere_virtual_machine" instances from the templates
   name          = var.template
   datacenter_id = var.config.datacenter
 }
resource "vsphere_virtual_machine" "vm" {
  name                        = "${var.name}_${var.template}"
  resource_pool_id            = var.config.resource_pool
  datastore_id                = var.config.datastore
  host_system_id              = var.host
  folder                      = var.folder
       
  wait_for_guest_net_timeout = var.network_waiter // fix Error: timeout waiting for an available IP address

  num_cpus = var.virtual_machine_num_cpus
  memory   = var.virtual_machine_memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type





  dynamic "network_interface" {
    # Include this block only if var.out_attack is
    # set to a non-null value.
    for_each = var.attack_network[*]
    content {
      network_id = network_interface.value
    }
  }
  dynamic "network_interface" {
    # Include this block only if var.out_attack is
    # set to a non-null value.
    for_each = var.out_attack[*]
    content {
      network_id = network_interface.value
    }
  }
    dynamic "network_interface" {
    # Include this block only if var.out_attack is
    # set to a non-null value.
    for_each = var.out_control[*]
    content {
      network_id = network_interface.value
    }
  }
  //This “special power” of the splat operators is intended as a way to concisely adapt between a possibly-null single value and a list, because repetition based on lists is generally how Terraform generalizes situations where something is conditionally present.
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
