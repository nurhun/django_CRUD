#!/bin/bash -x
IMAGE_NAME="nurhun/django_crud"
IMAGE_TAG="v0.1"

docker tag  ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
