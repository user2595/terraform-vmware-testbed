# Finally, we're outputting the IP address of the new VM
 output "out_ip_address" {
  value = module.experiment.ip_address
  description = "The Remote desktop IP address of the attackker instance."
 }