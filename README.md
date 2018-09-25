# n3tdom_infra
n3tdom Infra repository
- [n3tdom_infra](#n3tdom_infra)
    - [hw-0x шаблон](#hw-0x-шаблон)
        - [](#)
        - [Задание со * #1](#Задание-со--1)
    - [hw-08 ansible-3](#hw-08-ansible-3)
        - [](#1)
        - [Задание со * #1](#Задание-со--1-1)
    - [hw-07 ansible-2](#hw-07-ansible-2)
        - [Разделение задач по тегам, плейбукам.](#Разделение-задач-по-тегам-плейбукам)
        - [Задание со * #1](#Задание-со--1-2)
    - [hw-06 ansible-1](#hw-06-ansible-1)
        - [Плейбук](#Плейбук)
        - [Задание со * #1](#Задание-со--1-3)
    - [hw-05 terraform-1](#hw-05-terraform-1)
        - [Основное задание](#Основное-задание)
        - [Задание со * #1 - add remote backend](#Задание-со--1---add-remote-backend)
        - [Задание со * #2 - add provision](#Задание-со--2---add-provision)
    - [hw-04 terraform-1](#hw-04-terraform-1)
        - [Самостоятельные задания 1-4](#Самостоятельные-задания-1-4)
        - [Задание со * #1 - добавление ssh ключа пользователя appuser1 в метаданные проекта](#Задание-со--1---добавление-ssh-ключа-пользователя-appuser1-в-метаданные-проекта)
        - [Задание со * #2 - создание HTTP балансировщика (WIP)](#Задание-со--2---создание-http-балансировщика-wip)
    - [hw-03 packer-base](#hw-03-packer-base)
        - [Самостоятельное задание 1 и 2 - параметризация](#Самостоятельное-задание-1-и-2---параметризация)
        - [Самостоятельное задание 3 - дополнительные параметры](#Самостоятельное-задание-3---дополнительные-параметры)
        - [Задание со * #1 - образ с автозапуском приложения](#Задание-со--1---образ-с-автозапуском-приложения)
    - [hw-02 cloud-testapp](#hw-02-cloud-testapp)
        - [Дополнительное задание: startup scirpt](#Дополнительное-задание-startup-scirpt)
        - [Дополнительное задание: firewall](#Дополнительное-задание-firewall)
    - [hw-01 cloud-bastion](#hw-01-cloud-bastion)
        - [Подключение через промежуточный хост одной командой:](#Подключение-через-промежуточный-хост-одной-командой)
        - [Подключение через промежуточный хост алиасом:](#Подключение-через-промежуточный-хост-алиасом)

---
## hw-0x шаблон
### 


### Задание со * #1


---
## hw-08 ansible-3
### 


### Задание со * #1

---
## hw-07 ansible-2
### Разделение задач по тегам, плейбукам. 
- деплой приложения через плейбук
- сборка пакер образов с использованием плейбуков ансибл. Билд образов нужно производить из корня репозитория
    ```cd n3tdom_infra
    packer validate -var-file=packer/variables.json packer/app.json
    packer build -var-file=packer/variables.json packer/app.json
    ```

### Задание со * #1
dynamic inventory реализован через gce.py
Запуск ``` ansible-playbook site.yml ``` приводит к наполнению нужных хостов, указаны через anbible группы по типу tag_reddit-app-stage


---
## hw-06 ansible-1
### Плейбук
После rm директории плейбук отрабатывает, а не просто сообщает о том что репозиторий уже склонирован, поэтому статус меняется на changed

### Задание со * #1 
Создан файл inventory.json по последнему примеру отсюда https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html

Так как по заданию нам хватит статической конфигурации, написан простой скрипт по команде inventory.sh --list выдающий исходный inventory.json

---
## hw-05 terraform-1

### Основное задание
- Код разбит на модули и среды
- В модулях параметризирована среда (prod / stage)
- tfstate вынесены на remote-backend, gcs bucket

### Задание со * #1 - add remote backend
После добавления backend 
- Состояние обьектов видно при отсутствии локального tfstate
- В момент ожидания тераформом подтверждения terraform apply создается файл блокировки. Паралельное применение конфигураций не возможно:
Error: Error locking state: Error acquiring the state lock: writing "gs://n3tdom-stage/tfstate/default.tflock" failed: googleapi: Error 412: Precondition Failed, conditionNotMet

### Задание со * #2 - add provision
- Добавлен ресурс провижена для инстанса app
- db_address получается из output переменной и передается в ресурс провижена app
- Пересобран packer образа db.json для изменения адреса на котором слушает mongod

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
