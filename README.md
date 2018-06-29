# n3tdom_infra
n3tdom Infra repository

## Самостоятельное задание 1 и 2 - параметризация
## Manually
    packer validate \
        -var 'project_id=infra-208211' \
        -var 'source_image_family=ubuntu-1604-lts' \
        -var 'machine_type=f1-micro' \
        ubuntu16.json
## Via file
    packer validate -var-file=variables.json ubuntu16.json

## Connection info
### cloud-testapp
testapp_IP = 35.228.152.234
testapp_port = 9292





image_labels 