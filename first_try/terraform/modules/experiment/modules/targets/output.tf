# Finally, we're outputting the IP address of the new attacker vm
output "ip_address" {
  value = "${vsphere_virtual_machine.vm[var.template[0]].default_ip_address}" // TODO find a nice spelling 
  description = "The Remote desktop IP address of the  instance."
}