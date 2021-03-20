variable "network_public"           {default  = "SEC_Testbed_Uplink"}
variable "template"                 {default = "kaliVM"}
variable "config"   {}
variable "name"     {}
variable "host"     {}
variable "folder" {}
variable "network" {}
##########################################################################
############ VM-bezifisch ################################################
##########################################################################
variable "virtual_machine_name"         {default= "attacker"}
variable "virtual_machine_num_cpus"     {default= 4 }
variable "virtual_machine_memory"       {default= 16384}
variable "virtual_machine_disk_label"   {default= "disk0"}

