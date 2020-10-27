# Finally, we're outputting the IP address of the new VM
output "ip_address" {
 value = module.attacker.ip_address
}