variable "experiment_out" {}
variable "config"   {}
locals{
    control_ip = [for host in keys(var.experiment_out):
                    var.experiment_out[host]
                    if split("_", host)[1]  == "controlvm"
     ]
     attack_ip = [for host in keys(var.experiment_out):      
                    var.experiment_out[host]
                    if split("_", host)[1]  == "kaliVM"
     ]
     other_ip = setsubtract(values(var.experiment_out),concat(local.control_ip,local.attack_ip) )
     
}

