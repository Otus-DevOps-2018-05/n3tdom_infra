# n3tdom_infra
n3tdom Infra repository

---

## hw-04 terraform-1

### Самостоятельные задания 1-4
    
### Задание со * #1 -  добавление ssh ключа пользователя appuser1 в метаданные проекта
- Понять как составить конфиг для параметра было сложнее всего
    https://www.terraform.io/docs/providers/google/r/compute_project_metadata.html
    Adding or removing project-wide public SSH keys > api
    https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys#project-wide
    Документация конкретно ни о чем не сообщает.
    - Название ключей узнал через
    `gcloud compute project-info describe
    terraform import google_compute_project_metadata_item.default ssh-keys`
    - Итого опытным путем выяснилось что:
    `google_compute_project_metadata ответчает за раздел ssh-keys
    google_compute_project_metadata_item за раздел metadata`
    Был бы рад узнать лучший способ это выяснить.
    
- Итем google_compute_project_metadata_item с ключом ssh-keys уникален для проекта, т.е. может быть только один
- terraform apply ожидаемо стирает добавленный через веб-интерфейс ключ.


### Задание со * #2 - создание HTTP балансировщика (WIP)
1. В веб интерфейсе GCP > Load Balancers в advanced view создал необходимые итемы для лоад балансера.
2. После того как схема заработала - импортировал код в терраформ помощью команд вида:
     terraform import google_compute_http_health_check.default reddit-check
3. После чего terraform apply показывает какие параметры не дефолтные, их остается задать в lb.tf

Отдельно, добавил count к **instance**

---

## hw-03 packer-base

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

## hw-02 cloud-testapp
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

## hw-01 cloud-bastion
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
