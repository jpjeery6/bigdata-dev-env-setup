#!/bin/bash
set -e

# https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database
#sudo apt update
#sudo apt install -y mysql-server
mysql --version

# get mysql connector for the mysql server
USER=`whoami`
INSTALL_DIR="/home/$USER/bigdata-installation"
mkdir -p $INSTALL_DIR/opt
MYSQL_VERSION=`mysql --version | cut -d ' ' -f 4|cut -d '-' -f 1`
curl --progress-bar -L \
    "https://repo1.maven.org/maven2/mysql/mysql-connector-java/$MYSQL_VERSION/mysql-connector-java-$MYSQL_VERSION.jar" \
    --output "$INSTALL_DIR/opt/mysql-connector-java-$MYSQL_VERSION.jar"

#sudo /etc/init.d/mysql start
#sudo mysql_secure_installation # set password as root here
#sudo mysql < ./setup_mysql_hive.sql


# #By default your hive user is APP and password is mine