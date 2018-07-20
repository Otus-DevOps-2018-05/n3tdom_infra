# n3tdom_infra
n3tdom Infra repository

---

## hw terraform-1

### Самостоятельные задания 1-4
    

### Задание со * #1
Исходил из следующей инфы:
Adding or removing project-wide public SSH keys > api
https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys
google_compute_project_metadata_item 
https://www.terraform.io/docs/providers/google/r/compute_project_metadata_item.html
https://www.terraform.io/docs/import/index.html

0. gcloud compute project-info describe
1. Добавил в конфигурацию инфо о ресурсе и переменную (оставил пустой)
2. Сделал `terraform import google_compute_project_metadata_item.default ssh-keys`
3. Заполнил переменную в соотв. с инфо в api
4. terraform plan / apply


---

## hw packer-base

### Самостоятельное задание 1 и 2 - параметризация
Manually

    packer validate \
        -var 'project_id=infra-208211' \
        -var 'source_image_family=ubuntu-1604-lts' \
        -var 'machine_type=f1-micro' \
        ubuntu16.json

Via file

    packer validate -var-file=variables.json ubuntu16.json

### Самостоятельное задание 3 - дополнительные параметры
        Добавлены
        "ssh_username": "",
        "image_description": "",
        "disk_size": "10",
        "disk_type": "pd-standard",
        "tags": "",
        "network":""

### Задание со * #1 - образ с автозапуском приложения

Образ сделан поверх существующего reddit-base
Собрать можно командой packer build -var-file immutable_variables.json immutable.json
Запустить можно через create-reddit-vm.sh

---

## hw cloud-testapp
testapp_IP = 35.228.152.234
testapp_port = 9292

### Дополнительное задание: startup scirpt
См ``startup.sh``

Локально

        gcloud compute instances create reddit-app\
        --boot-disk-size=10GB \
        --image-family ubuntu-1604-lts \
        --image-project=ubuntu-os-cloud \
        --machine-type=g1-small \
        --tags puma-server \
        --restart-on-failure \
        --metadata-from-file startup-script=startup.sh

По вебу

        gcloud compute instances create reddit-app\
        --boot-disk-size=10GB \
        --image-family ubuntu-1604-lts \
        --image-project=ubuntu-os-cloud \
        --machine-type=g1-small \
        --tags puma-server \
        --restart-on-failure \
        --metadata startup-script-url=gs://bucket/startupscript.sh

### Дополнительное задание: firewall

    gcloud compute firewall-rules create "default-puma-server-9292" \
            --allow tcp:9292 \
            --source-ranges="0.0.0.0/0" \
            --target-tags=puma-server  \
            --description="HTTP access"

---

## hw cloud-bastion
bastion_IP = 35.228.119.210
someinternalhost_IP = 10.166.0.3

### Подключение через промежуточный хост одной командой:
    ssh -J n3tdom@35.228.119.210 n3tdom@10.166.0.3

### Подключение через промежуточный хост алиасом:
ssh_config

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

Само подключение

        ➜  n3tdom_infra git:(cloud-bastion) ✗ ssh gcp-int
        Last login: Sun Jun 24 12:20:30 2018 from 10.166.0.2
        n3tdom@someinternalhost:~$ 

Источник https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Proxies_and_Jump_Hosts