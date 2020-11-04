#########################################################################
######### Provider#######################################################
#########################################################################
variable "vsphere_user"                         {default= "dai\\moussa"}
variable "vsphere_password"                     {}
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
//variable "vsphere_network_public"               {default= "SEC_Testbed_Uplink" }
##########################################################################
############ Templates ###############################################
##########################################################################
variable "template_dhcp"                        {default = "sec-dhcp"}
variable "template_kali"                        {default = "kaliVM"}  
variable "template_MinUv2"                      {default = "MinUv2"} 
variable "template_MinUv1"                      {default = "MinUv1"} 
##########################################################################
############ experiments ###############################################
##########################################################################
variable"experiment_0"                          {default ="experiment_MinUv2" }
variable"experiment_1"                          {default ="experiment_MinUv1" }
variable"experiment_2"                          {default ="experiment_MinUv2_MinUv1" }
##########################################################################
############ experments Parameter ###############################################
##########################################################################
locals {
  templates = list(var.template_dhcp,var.template_kali,var.template_MinUv2,var.template_MinUv1)
  network_public =  "SEC_Testbed_Uplink" 
  host   = data.vsphere_host.host.id
  config = {
              datacenter= data.vsphere_datacenter.dc.id
              datastore= data.vsphere_datastore.datastore.id
              resource_pool=data.vsphere_resource_pool.pool.id
              cluster=data.vsphere_compute_cluster.cluster.id
              host=data.vsphere_host.host.id
}
}
