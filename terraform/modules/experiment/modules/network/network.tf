resource "vsphere_host_virtual_switch" "switch_attack" {
  count          =  var.attack_flag   // 0 or 1 
  name           = "${var.name}_switch_attack"
  host_system_id = var.host
  network_adapters = []
  active_nics  = []
  standby_nics = []
}
resource "vsphere_host_port_group" "pg_attack" {
  depends_on = [vsphere_host_virtual_switch.switch_attack]
  count          =  var.attack_flag   // 0 or 1 
  name                = "${var.name}_attack"
  host_system_id      = var.host
  virtual_switch_name = vsphere_host_virtual_switch.switch_attack[0].name

  provisioner "local-exec" {
    command = "sleep 5"
  }
}
data "vsphere_network" "attack_network" {
  count          =  var.attack_flag   // 0 or 1 
  depends_on = [vsphere_host_port_group.pg_attack]       // Depends_on says that "attack_network" is dependent on "vsphere_host_port_group.pg"
  name          = vsphere_host_port_group.pg_attack[0].name
  datacenter_id = var.config.datacenter
}


resource "vsphere_host_virtual_switch" "switch_control" {
  count          =  var.control_flag   // 0 or 1 
  name           = "${var.name}_switch_control"
  host_system_id = var.host
  network_adapters = []
  active_nics  = []
  standby_nics = []
}
resource "vsphere_host_port_group" "pg_control" {
  depends_on          = [vsphere_host_virtual_switch.switch_control] // Depends_on says that "attack_network" is dependent on "vsphere_host_virtual_switch.switch_control"
  count               =  var.control_flag   // 0 or 1 
  name                = "${var.name}_control"
  host_system_id      = var.host
  virtual_switch_name = vsphere_host_virtual_switch.switch_control[0].name

  provisioner "local-exec" {
    command = "sleep 5"
  }
}
data "vsphere_network" "control_network" {
  count          =  var.control_flag   // 0 or 1 
  depends_on = [vsphere_host_port_group.pg_control]       // Depends_on says that "attack_network" is dependent on "vsphere_host_port_group.pg"
  name          = vsphere_host_port_group.pg_control[0].name
  datacenter_id = var.config.datacenter
}
