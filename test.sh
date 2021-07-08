#!/bin/bash

USER=`whoami`
INSTALL_DIR="/home/$USER/bigdata"
mkdir -p $INSTALL_DIR/opt
MYSQL_VERSION=`mysql --version | cut -d ' ' -f 4|cut -d '-' -f 1`
curl --progress-bar -L \
    "https://repo1.maven.org/maven2/mysql/mysql-connector-java/$MYSQL_VERSION/mysql-connector-java-$MYSQL_VERSION.jar" \
    --output "$INSTALL_DIR/opt/mysql-connector-java-$MYSQL_VERSION.jar"