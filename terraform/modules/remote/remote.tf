module "controller" {
    source              = "./modules/executor"
    connection_host     = local.control_ip[0]
    connection_user     = local.control_username[0]
    connection_type     = "ssh"
   
    remote_exec_command = [ "sudo apt-get install python3 python3-pip sshpass -y ;", 
                                            "sudo pip3 install ansible lxml" ]
    path_to_playbook    = "dummyPlaybook.yml"
}

