#!/bin/bash
sudo apt update -y
sudo apt install openjdk-11-jdk -y
java -version
VERSION=6.8.3
sudo unzip -d /opt/gradle /tmp/gradle-${VERSION}-bin.zip
sudo ln -s /opt/gradle/gradle-${VERSION} /opt/gradle/latest
echo "export GRADLE_HOME=/opt/gradle/latest" >> /etc/profile.d/gradle.sh
echo "export PATH=${GRADLE_HOME}/bin:${PATH}" >> /etc/profile.d/gradle.sh
sudo chmod +x /etc/profile.d/gradle.sh
ls /opt/gradle
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
gradle --version

## Provision Jenkins Master Access
sudo su
useradd jenkinsmaster -m
echo "jenkinsmaster:jenkinsmaster" | chpasswd  ## Ubuntu

## Enable Password Authentication and Authorization
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "jenkinsmaster ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chown -R jenkinsmaster:jenkinsmaster /opt

## Install git
apt install git -y