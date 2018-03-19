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
