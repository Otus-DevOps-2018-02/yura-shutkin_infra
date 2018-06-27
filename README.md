# yura-shutkin_infra
yura-shutkin Infra repository

## Requirements installation

### Pre requisites:

I'm using Ubuntu 16.04. So if you have another distro or OS this steps can be useless for you.

### Ruby 2.0.0 localy without sudo rights

1. Get [RVM](http://rvm.io/)
```bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
```
2. Install ruby
```bash
source /home/yshutkin/.rvm/scripts/rvm
rvm install 2.0.0 --autolibs=0 
```
Tanks to [http://scottolesen.com/post/installing-ruby-without-sudo/](http://scottolesen.com/post/installing-ruby-without-sudo/)

### Install Travis cli
```bash
gem install travis -v 1.8.8 --no-rdoc --no-ri
```

## Reddit app up and running
```bash
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script-url=https://raw.githubusercontent.com/Otus-DevOps-2018-02/yura-shutkin_infra/cloud-testapp/config-scripts/startup.s
```

#### Reddit app requisites
```bash
testapp_IP = 35.204.200.177
testapp_port = 9292
```

### Open default puma server port on firewall
```bash
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --network default --source-ranges 0.0.0.0/0 --target-tags puma-server
```

## Packer

home link: [https://www.packer.io](https://www.packer.io)

### Description
* ubuntu16.json - base image. Contains only ruby and mongodb

### Examples
```bash
cd packer
packer validate -var-file=variables.json ubuntu16.json
packer build -var-file=variables.json ubuntu16.json

packer validate -var-file=variables.json immutable.json
packer build -var-file=variables.json immutable.json
```
```bash
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family reddit-base --image-project={{ your-project-id }} --machine-type=g1-small --tags puma-server --restart-on-failure

gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family reddit-full --image-project={{ your-project-id }} --machine-type=g1-small --tags puma-server --restart-on-failure
```
or to create VM with reddit app
```bash
config-scripts/create-reddit-vm.sh
```

## Terraform-1

Troubles with project metadata:
* Format is "user:${path}other_user:${path}"
* appuser_web ssh key not visible with command ```terraform plan``` nor ```terraform apply```

## Terraform-2

prod configs path terraform/prod

stage configs path terraform/stage

states stored at storage-bucket-test-615c5b82c33a352b-1

If you run terraform apply on both directories you'll get error with something like: resource already exists

## Tips and Tricks

If you wish connect to your server through bastion host you can setup ~/.ssh/config like this

With the same ssh key
```bash
Host someinternalhost
    HostName 10.0.0.2
    IdentityFile ~/.ssh/appuser
    User appuser
    ProxyCommand ssh -A bastion -W %h:%p

Host bastion
    HostName bastion.mydomain.com
    User appuser
    IdentityFile ~/.ssh/appuser

```
```bash
ssh someinternalhost
```
With the different keys
```bash
Host someinternalhost
    HostName 10.164.0.3
    IdentityFile ~/.ssh/appuser
    User appuser
    ProxyCommand ssh -A bastion -W %h:%p

Host bastion
    HostName 35.204.5.57
    User yshutkin
    IdentityFile ~/.ssh/id_rsa
```
```bash
ssh someinternalhost
```

### Specific settings

```bash
bastion_IP = 35.204.5.57
someinternalhost_IP = 10.164.0.3
```
