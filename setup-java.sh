#!/bin/bash
set -e

#java -version
#sudo apt-get purge --auto-remove openjdk*
#sudo update-alternatives --config java

sudo apt update
# may be this can be avoided and download openjdk via vs code ui
#sudo apt install -y openjdk-11-jdk #required by vs code Redhat Java Language  server
sudo apt install -y openjdk-8-jdk #required by hive (big data projects run best with java 8)

java -version

#sudo apt install maven
#mvn --version

