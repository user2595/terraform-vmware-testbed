#########################################################################
######### Provider#######################################################
#########################################################################
variable "vsphere_user"                         {default= "dai\\moussa"}
variable "vsphere_password"                     {default = "Sonne21§"}
variable "vsphere_server"                       {default="vcenter.dai-lab.de"}
# If you have a self-signed cert
variable "vsphere_unverified_ssl"               {default= true }
variable "vsphere_version"                      {default= "1.15.0"} 
##########################################################################
############ DAI-bezifisch ###############################################
##########################################################################
variable "vsphere_datacenter"                   {default= "DAI-Labor"}
variable "vsphere_datastore"                    {default= "VM-Storage3"}
variable "vsphere_resource_pool"                {default= "Testbed"}
variable "vsphere_cluster"                      {default= "UCS"}
variable "vsphere_host_name"                    {default="vsphere7.dai-lab.de"}
variable "vsphere_out_attack"                   {default= "SEC_Testbed_Uplink" }
//variable "vsphere_out_control"               {default= "" }
##########################################################################
############ Templates ###############################################
##########################################################################
variable "template_dhcp"                        {default = "sec-dhcp"}
variable "template_attacker"                    {default = "kaliVM"} 
variable "template_control"                    {default = "controlvm"}  
variable "template_MinUv2"                      {default = "MinUv2"} 
variable "template_MinUv1"                      {default = "MinUv1"} 
variable "template_linux"                      {default = "linux"} 
variable "template_securtiyOnion"              {default = "securtiyOnion"} 
variable "template_windows-10"                 {default = "windows-10"} 
##########################################################################
############ Usernames ###############################################
##########################################################################
variable "linux_username"                      {default = "master"}
variable "kali_username"                        {default = "kalivm"} 
variable "securtiyOnion_username"              {default = "zwiebel"} 
variable "windows_username"                     {default = "windows-1"} 
##########################################################################
############ experiments ###############################################
##########################################################################
variable"experiment_0"                          {default ="experiment_0" }
variable"experiment_1"                          {default ="experiment_1" }
variable"experiment_2"                          {default ="experiment_2" }
##########################################################################
############ experments Parameter ###############################################
##########################################################################
locals { 
  config = {
              datacenter= data.vsphere_datacenter.dc.id
              datastore= data.vsphere_datastore.datastore.id
              resource_pool=data.vsphere_resource_pool.pool.id
              cluster=data.vsphere_compute_cluster.cluster.id           
}
experiment_0 = {
  name                  = "experiment_0"
  host                  = "vsphere7.dai-lab.de"
  out_attack            = data.vsphere_network.out_attack.id
  out_control           = data.vsphere_network.out_attack.id 
  creat_attack_network  = true
  creat_control_network = true
  maschinen             = local.vm_experiment_0
  }


 vm_experiment_0 = [
{
  template = var.template_dhcp
  username = var.linux_username
  out_attack = false
  out_control = false
  attack_network = true
  control_network = true
  network_waiter = false

},
{
  template = var.template_attacker
  username = var.kali_username
  out_attack = true
  out_control = false
  attack_network = true
  control_network = false
  network_waiter = true
},{
  template = var.template_control
  username = var.linux_username
  out_attack = false
  out_control = true
  attack_network = false
  control_network = true
  network_waiter = true
},
{
  template = var.template_MinUv2
  username = null
  out_attack = false
  out_control = false
  attack_network = true
  control_network = true
  network_waiter = false
  },
# {
#   template = var.template_MinUv1
#   out_attack = false
#   out_control = false
#   attack_network = true
#   control_network = true
#   network_waiter = false
# },{  
#   template = var.template_linux
#   username = var.linux_username
#   out_attack = false
#   out_control = false
#   attack_network = true
#   control_network = true
#   network_waiter = false
# },{  
#   template = var.template_windows-10
#   username = var.windows_username
#    out_attack = false
#   out_control = false
#   attack_network = true
#   control_network = true
#   network_waiter = false
# },

]


 
}








