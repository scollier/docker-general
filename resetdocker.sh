#!/bin/bash
# scollier 12/18/2012

__stop_containers() {
for i in `docker ps | awk '{ print $1 }'`; do docker stop $i; done
}

__remove_images() {
for i in `docker images | awk '{ print $3 }'`; do docker rmi $i; done
}

__remove_containers() {
for i in `docker ps -a | awk '{ print $1 }'`; do docker rm $i; done
}

__remove_device() {
for i in /dev/mapper/docker-*; do umount $i; dmsetup remove $i; done
}

__restart_docker() {
systemctl restart docker.service
}

__stop_containers
__remove_images
__remove_containers
__remove_device
__restart_docker
