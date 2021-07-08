#!/bin/bash

ssh localhost

apt list ssh
sudo apt install ssh

ps -ef | grep ssh
sudo service ssh start

#one time only
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys