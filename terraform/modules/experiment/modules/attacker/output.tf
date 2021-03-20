# Finally, we're outputting the IP address of the new attacker vm
output "ip_address" {
 value = "${vsphere_virtual_machine.vm.default_ip_address}"
  description = "The Remote desktop IP address of the attackker instance."
}