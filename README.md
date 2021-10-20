## General setup
set the ansible-vault password (from Teampass)
```console
echo <password> > ./ansible/.vault_pass
```

Initialize the project, which downloads a plugin that allows Terraform to interact with Docker.
```console
$ terraform init
```
Provision the Testbed with apply. When Terraform asks you to confirm type yes and press ENTER.
```console
$ terraform apply
```
To stop the container, run terraform destroy.
```console
$ terraform destroy
```
You  now provisioned and destroyed an Testbed with Terraform.

## Configure a deployment



set in the /terraform/var.tf the deployment specific variables
```console

  experiment_<N>_name                  = "name"                     # Name of the deployment
  experiment_<N>_host                  = "vsphere<i>.dai-lab.de"    # indicates on which host the vm will be created   
                                                                                  vsphere<i>.dai-lab.de i =[1,12]
  experiment_<N>_creat_attack_network  = true/false                 # flag to creat intern attack network
  experiment_<N>_creat_control_network = true/false                 # flag to creat intern control network
                 
  experiment_<N>_maschinen = [
 {
   template = var.template  
   username = null
   out_attack = true/false
   out_control = true/false
   attack_network = true/false
   control_network = true/false
   network_waiter = true/false
   use_static_mac = true/false
 },
    .
    .
    .

]

```

set in the /terraform/root.tf an deployment block 
```console
module "deployment<N>" {                                                        # <N> means the nummber of deployment
    source                        = "./modules/deployment"                      # tells terraform which module to load  
    config                        = local.config                                # general configuration for the dai-vmware-center 
    name                          = local.experiment_<N>_name                   # Name of the deployment
    host                          = local.experiment_<N>_host                   # indicates on which host the vm will be created   
                                                                                  vsphere<i>.dai-lab.de i =[1,12]
    creat_attack_network          = local.experiment_<N>_creat_attack_network   # flat to creat intern attack network  
    creat_control_network         = local.experiment_<N>_creat_control_network  # flag to creat intern control network
    maschinen                     = local.experiment_<N>_maschinen              # list of vm to creaed
    }
```



