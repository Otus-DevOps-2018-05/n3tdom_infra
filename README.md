# n3tdom_infra
n3tdom Infra repository

## Дополнительное задание: startup scirpt
См startup.sh

### Локально
    gcloud compute instances create reddit-app\
    --boot-disk-size=10GB \
    --image-family ubuntu-1604-lts \
    --image-project=ubuntu-os-cloud \
    --machine-type=g1-small \
    --tags puma-server \
    --restart-on-failure \
    --metadata-from-file startup-script=startup.sh

### По вебу
    gcloud compute instances create reddit-app\
    --boot-disk-size=10GB \
    --image-family ubuntu-1604-lts \
    --image-project=ubuntu-os-cloud \
    --machine-type=g1-small \
    --tags puma-server \
    --restart-on-failure \
    --metadata startup-script-url=gs://bucket/startupscript.sh

## Дополнительное задание: firewall
gcloud compute firewall-rules create "default-puma-server-9292" \
      --allow tcp:9292 \
      --source-ranges="0.0.0.0/0" \
      --target-tags=puma-server  \
      --description="HTTP access"

## Connection info
### cloud-testapp
testapp_IP = 35.228.152.234
testapp_port = 9292
