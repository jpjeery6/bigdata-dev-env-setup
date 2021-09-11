#!/bin/bash
set -e

. ./init.sh


if [ -d "$HIVE_DIR" ]; then
  rm -rf $HIVE_DIR
  mkdir -p $HIVE_DIR
fi

# wget https://downloads.apache.org/hive/hive-$HIVE_V/apache-hive-$HIVE_V-bin.tar.gz -P $DOWNLOAD_DIR/
# 
tar -xzf $DOWNLOAD_DIR/apache-hive-$HIVE_V-bin.tar.gz -C $HIVE_DIR

##### Config

#. ./setup-mysql.sh

# FIX GUAVA JAR VERSION ISSUE
HIVE_GUAVA_JAR=`ls $HIVE_HOME/lib/ | grep '^guava'`
HADOOP_GUAVA_JAR=`ls $HADOOP_HOME/share/hadoop/common/lib/ | grep '^guava'`
echo "Hive Guava jar: $HIVE_GUAVA_JAR"
echo "Hadoop Guava jar: $HADOOP_GUAVA_JAR"
if [ "$HIVE_GUAVA_JAR" != "$HADOOP_GUAVA_JAR" ]; then
    rm $HIVE_HOME/lib/$HIVE_GUAVA_JAR
    cp $HADOOP_HOME/share/hadoop/common/lib/$HADOOP_GUAVA_JAR $HIVE_HOME/lib/
fi

# remove hive's logging jar as there are multiple logging jars found in hadoop and hive
HIVE_SLF4J_JAR=`ls $HIVE_HOME/lib/ | grep 'log4j-slf4j-impl'`
rm $HIVE_HOME/lib/$HIVE_SLF4J_JAR

# mysql connector jar - jar download done by setup-mysql.sh script
# https://mvnrepository.com/artifact/mysql/mysql-connector-java
#cp ./mysql-connector.jar $HIVE_HOME/lib/mysql-connector-java.jar
MYSQL_VERSION=`mysql --version | cut -d ' ' -f 4|cut -d '-' -f 1`
ln -s $INSTALL_DIR/opt/mysql-connector-java-$MYSQL_VERSION.jar  $HIVE_HOME/lib/mysql-connector-java.jar

# config - dynamic injection of user_name
cp ./hive_conf/hive-site.xml.template ./hive_conf/hive-site.xml
sed -i "s%user_name%$USER%g" ./hive_conf/hive-site.xml
cp ./hive_conf/hive-site.xml $HIVE_HOME/conf/hive-site.xml
rm ./hive_conf/hive-site.xml

cp $HIVE_HOME/conf/hive-env.sh.template $HIVE_HOME/conf/hive-env.sh
echo "export JAVA_HOME=$JAVA_V" >> $HIVE_HOME/conf/hive-env.sh



# in case of derby need to provide path
# cp ./hive_conf/hive-site.xml.template ./hive_conf/hive-site.xml
# sed -i "s%user_name%$USER%g" ./hive_conf/hive-site.xml
# cp ./hive_conf/hive-site.xml $HIVE_HOME/conf/hive-site.xml
# rm ./hive_conf/hive-site.xml

schematool -dbType mysql -initSchema
#useSSL=false
#autoReconnect=true


#spark.driver.extraClassPath and point to: hive-exec-1.2.1.jar
#bin/hiveserver2
#bin/beeline -u jdbc:hive2://localhost:10000
#hive -f hive_testing.hql