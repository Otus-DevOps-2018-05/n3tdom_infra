#!/bin/bash
gcloud compute instances create reddit-app-$(date +'%Y-%m-%d-%H-%M-%S') \
    --image-family=reddit-full \
    --image-project=infra-208211  \
    --machine-type=g1-small \
    --restart-on-failure \
    --tags=puma-server \
    --preemptible
