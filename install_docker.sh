#! /bin/bash
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt -y update
sudo apt install -y openjdk-11-jdk
sudo apt  install -y docker.io
sudo chmod 666 /var/run/docker.sock