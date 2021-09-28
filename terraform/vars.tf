#########################################################################
######### Provider#######################################################
#########################################################################
variable "vsphere_user"                         {default= "secAdmin"}
variable "vsphere_server"                       {default="vcenter.dai-lab.de"}
# If you have a self-signed cert
variable "vsphere_unverified_ssl"               {default= true }
variable "vsphere_version"                      {default= "1.15.0"} 
##########################################################################
############ Ansible_Vault ###############################################
##########################################################################
variable "ansible_vault_source"                 {default="MeilleursAgents/ansiblevault" }
variable "ansible_vault_version"                {default= "2.2.0"}
variable "ansible_vault_vault_path"             {default="../ansible/.vault_pass"}
variable "ansible_vault_root_folder"            {default= "../ansible"}
variable "ansible_vault_password_path"          {default= "passwords.yml" }
##########################################################################
############ DAI-bezifisch ###############################################
##########################################################################
variable "vsphere_datacenter"                   {default= "DAI-Labor"}
variable "vsphere_datastore"                    {default= "VM-Storage3"}
variable "vsphere_resource_pool"                {default= "Testbed"}
variable "vsphere_cluster"                      {default= "UCS"}
variable "vsphere_host_name"                    {default="vsphere7.dai-lab.de"}
variable "vsphere_out_attack"                   {default= "SEC_Testbed_Uplink" }
variable "vsphere_out_control"                  {default= "SEC_Testbed_Uplink" }
##########################################################################
############ Templates ###############################################
##########################################################################
variable "template_dhcp"                        {default = "sec-dhcp"}
variable "template_attacker"                    {default = "kaliVM"} 
variable "template_control"                     {default = "controlvm"}  
variable "template_MinUv2"                      {default = "MinUv2-Modify"} 
variable "template_MinUv1"                      {default = "MinUv1"} 
variable "template_linux"                       {default = "linux"} 
variable "template_securtiyOnion"               {default = "securtiyOnion"} 
variable "template_windows-10"                  {default = "windows-10"} 
variable "template_eHealth_router"              {default = "eHealth_router"}
variable "template_eHealth_non_Sensitive"       {default = "eHealth_non_Sensitive_D"}
variable "template_eHealth_Sensitive"           {default = "eHealth_Sensitive_D"}
variable "template_web_target_malicious"        {default = "web_target_malicious"}
variable "template_web_target_bening"           {default = "web_target_bening"}
##########################################################################
############ Usernames ###############################################
##########################################################################
variable "linux_username"                       {default = "master"}
variable "kali_username"                        {default = "kalivm"} 
variable "securtiyOnion_username"               {default = "zwiebel"} 
variable "windows_username"                     {default = "windows-1"} 
variable "eHealth_username"                     {default = "master"}
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

##############################################################################################  
//variables currently not in use 
############################################################################################## 
  prefix_nexus_releases = "https://repositories.dai-labor.de/extern/repository/acs-releases/"
  prefix_nexus_snapshot = "https://repositories.dai-labor.de/extern/repository/acs-snapshot/"
  version_radar         = "3.7.5"
  version_common        = "4.0.3"
  version_issu_tracker  = "2.0.2"
  version_cosy          = "4.0.5"
##############################################################################################  
##############################################################################################
  
  config = {
    datacenter          = data.vsphere_datacenter.dc.id
    datastore           = data.vsphere_datastore.datastore.id
    resource_pool       = data.vsphere_resource_pool.pool.id
    cluster             = data.vsphere_compute_cluster.cluster.id        
    out_attack          = data.vsphere_network.out_attack.id
    out_control         = data.vsphere_network.out_control.id    
  }
  
  experiment_0_name                  = "experiment_1"
  experiment_0_host                  = "vsphere12.dai-lab.de"
  experiment_0_creat_attack_network  = false
  experiment_0_creat_control_network = false
                 
  experiment_0_maschinen = [
# {
#   template = var.template_dhcp
#   username = var.linux_username
#   out_attack = false
#   out_control = false
#   attack_network = true
#   control_network = true
#   network_waiter = false
#   use_static_mac = true

# },
# {
#   template = var.template_attacker
#   username = var.kali_username
#   out_attack = true
#   out_control = false
#   attack_network = true
#   control_network = false
#   network_waiter = true
#   use_static_mac = true
# },
{
  template = var.template_control
  username = var.linux_username
  out_attack = false
  out_control = true
  attack_network = false
  control_network = false
  network_waiter = true
   use_static_mac = true
 },
# {
#   template = var.template_MinUv2
#   username = null
#   out_attack = false
#   out_control = false
#   attack_network = true
#   control_network = true
#   network_waiter = false
#   use_static_mac = true
#   },
# {
#   template = var.template_MinUv1
#   out_attack = false
#   out_control = false
#   attack_network = true
#   control_network = true
#   network_waiter = false
#   use_static_mac = false
# },{  
#   template = var.template_linux
#   username = var.linux_username
#   out_attack = false
#   out_control = false
#   attack_network = true
#   control_network = true
#   network_waiter = false
#   use_static_mac = false
# },{  
#   template = var.template_windows-10
#   username = var.windows_username
#    out_attack = false
#   out_control = false
#   attack_network = true
#   control_network = true
#   network_waiter = false
#   use_static_mac = false
# },
]
}








