module "attacker" {
    source              = "./modules/executor"
    connection_host     = local.control_ip[0]
    connection_user     = local.control_username[0]
    connection_type     = "ssh"
   
    remote_exec_command = [ "sudo apt install python3 python3-pip -y", 
                                            "pip3 install ansible lxml"]
    path_to_playbook    = "dummyPlaybook.yml"
}

