set the ansible-vault password (from Teampass)
```console
echo <password> > ./ansible/.vault_pass
``

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
