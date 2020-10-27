resource "vsphere_host_virtual_switch" "switch" {
  name           = "${var.name}_switch"
  host_system_id = var.host

  network_adapters = []

  active_nics  = []
  standby_nics = []
}
resource "vsphere_host_port_group" "pg" {
  name                = "${var.name}_pg"
  host_system_id      = var.host
  virtual_switch_name = vsphere_host_virtual_switch.switch.name

  provisioner "local-exec" {
    command = "sleep 5"
  }
}
data "vsphere_network" "inside_network" {
  depends_on = [vsphere_host_port_group.pg]       // Depends_on says that "inside_network" is dependent on "vsphere_host_port_group.pg"
  name          = vsphere_host_port_group.pg.name
  datacenter_id = var.config.datacenter
}
data "vsphere_network" "public_network" {
  depends_on    = [vsphere_host_port_group.pg]    // Depends_on says that "inside_network" is dependent on "vsphere_host_port_group.pg"
  name          = var.network_public
  datacenter_id = var.config.datacenter  
}
