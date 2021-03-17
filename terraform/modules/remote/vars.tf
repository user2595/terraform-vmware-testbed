
variable "config"   {}
variable "deployment_out_ip_list"{}
variable "deployment_out_username_list"{}

locals{
    control_ip = [for host in keys(var.deployment_out_ip_list):
                    var.deployment_out_ip_list[host]
                    if split("_", host)[1]  == "controlvm"
     ]
    control_username = [for host in keys(var.deployment_out_username_list):
                    var.deployment_out_username_list[host]
                    if split("_", host)[1]  == "controlvm"
     ]
     attack_ip = [for host in keys(var.deployment_out_ip_list):      
                    var.deployment_out_ip_list[host]
                    if split("_", host)[1]  == "kaliVM"
     ]
    attack_username = [for host in keys(var.deployment_out_username_list):      
                    var.deployment_out_username_list[host]
                    if split("_", host)[1]  == "kaliVM"
     ]
     other_ip       = setsubtract(values(var.deployment_out_ip_list),concat(local.control_ip,local.attack_ip) )
     
     other_username = setsubtract(values(var.deployment_out_username_list),concat(local.control_ip,local.attack_ip) )


    
         
}