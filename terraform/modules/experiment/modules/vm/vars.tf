variable "template"         {}
variable "network_waiter"   {default= 0}
variable "config"           {}
variable "name"             {}
variable "host"             {}
variable "folder"           {}
variable "control_network"   {
    type    = string 
    default = null                               
}
variable "out_control"   { 
    type    = string 
    default = null
}
variable "attack_network"   {
    type    = string 
    default = null                                 
}
variable "out_attack"   { 
    type    = string 
    default = null
}




 //https://discuss.hashicorp.com/t/how-do-write-an-if-else-block/2563/3
##########################################################################
############ VM-bezifisch ################################################
##########################################################################
variable "virtual_machine_name"         {default= "target_vm"}
variable "virtual_machine_num_cpus"     {default= 4 }
variable "virtual_machine_memory"       {default= 16384}
variable "virtual_machine_disk_label"   {default= "disk0"}

