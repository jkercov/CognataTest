#!/bin/bash

sudo apt update & upgrade
sudo apt install nginx
systemctl start nginx

sudo apt update
sudo apt install docker.io -y

sudo apt-get update
sudo apt-get install docker-compose-plugin