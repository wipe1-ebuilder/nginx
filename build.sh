#!/bin/sh -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME=dev_reverse_proxy
FULL_IMAGE_NAME=dev/corporate-actions-service/${IMAGE_NAME}
DOCKER_FILE_NAME=Dockerfile
DOCKER_REGISTRY=docker-registry.hq.local

clone_certificate(){
  echo "Cloning certificates"
  git clone ssh://git@git.hq.local:7999/at/workstation-vm.git && \
  cp workstation-vm/ansible-common/roles/nginx/conf/localhost-ioofonline-com-au.pem cert.pem && \
  cp workstation-vm/ansible-common/roles/nginx/conf/localhost-ioofonline-com-au.key certkey.key
}

cleanup(){
  rm -rf workstation-vm
  rm cert.pem
  rm certkey.key
}

trap cleanup EXIT

if [ "x$NO_DOCKER_CACHE" != "x" ]; then
  NO_CACHE="--no-cache"
fi

pushd .
cd ${DIR}

clone_certificate

echo "Starting build for IMAGE=${IMAGE_NAME}"

docker build -t ${FULL_IMAGE_NAME} .

NEW_IMAGE_ID=$(docker images -a | grep -E ${FULL_IMAGE_NAME}\\s | grep latest | awk '{print $3}')

docker tag ${NEW_IMAGE_ID} ${DOCKER_REGISTRY}/${FULL_IMAGE_NAME}:latest

if [ "x$NO_DOCKER_PUSH" = "x" ]; then
  docker push ${DOCKER_REGISTRY}/${FULL_IMAGE_NAME}:latest
fi


echo "Build complete for IMAGE=${IMAGE_NAME}"