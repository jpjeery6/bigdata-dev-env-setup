#!/bin/bash
set -e

. ./init.sh

if [ -d "$KAFKA_DIR" ]; then
  rm -rf $KAFKA_DIR
  mkdir -p $KAFKA_DIR
fi

#wget https://downloads.apache.org/hadoop/common/hadoop-$HADOOP_V/hadoop-$HADOOP_V.tar.gz -P $DOWNLOAD_DIR/
tar -xzf $DOWNLOAD_DIR/kafka_${SCALA_V}-${KAFKA_V}.tgz -C $KAFKA_DIR

# config - dynamic injection of user_name
cp ./kafka_conf/zookeeper.properties.template ./kafka_conf/zookeeper.properties
sed -i "s%user_name%$USER%g" ./kafka_conf/zookeeper.properties
cp ./kafka_conf/zookeeper.properties $KAFKA_HOME/config/zookeeper.properties
rm ./kafka_conf/zookeeper.properties

cp ./kafka_conf/server.properties.template ./kafka_conf/server.properties
sed -i "s%user_name%$USER%g" ./kafka_conf/server.properties
cp ./kafka_conf/server.properties $KAFKA_HOME/config/server.properties
rm ./kafka_conf/server.properties
# echo "export JAVA_HOME=$JAVA_V" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
# echo "export HADOOP_OPTS=\"-Djava.library.path=\$HADOOP_HOME/lib/native\"" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

