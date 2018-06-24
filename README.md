bastion_IP = 35.228.119.210
someinternalhost_IP = 10.166.0.3

# n3tdom_infra
n3tdom Infra repository

## Подключение через промежуточный хост одной командой:
    ssh -J n3tdom@35.228.119.210 n3tdom@10.166.0.3

## Подключение через промежуточный хост алиасом:
### ssh_config
    Host gcp-bastion
        Hostname 35.228.119.210
        Port 22
        User n3tdom
        IdentityFile /home/n3tdom/.ssh/my-cloud
        ForwardAgent yes

    Host gcp-int
        Hostname 10.166.0.3
        Port 22
        User n3tdom
        ProxyJump gcp-bastion

### Подключение
    ➜  n3tdom_infra git:(cloud-bastion) ✗ ssh gcp-int
    Last login: Sun Jun 24 12:20:30 2018 from 10.166.0.2
    n3tdom@someinternalhost:~$ 

Источник https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Proxies_and_Jump_Hosts
