#!/bin/bash
set -e

. ./init.sh

if [ -d "$HADOOP_DIR" ]; then
  rm -rf $HADOOP_DIR
  mkdir -p $HADOOP_DIR
fi

#wget https://downloads.apache.org/hadoop/common/hadoop-$HADOOP_V/hadoop-$HADOOP_V.tar.gz -P $DOWNLOAD_DIR/
tar -xzf $DOWNLOAD_DIR/hadoop-$HADOOP_V.tar.gz -C $HADOOP_DIR

echo "export JAVA_HOME=$JAVA_V" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
echo "export HADOOP_OPTS=\"-Djava.library.path=\$HADOOP_HOME/lib/native\"" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh


# config - dynamic injection of user_name for hdfs site, rest copy direct
cp ./hadoop_conf/hdfs-site.xml.template ./hadoop_conf/hdfs-site.xml
sed -i "s%user_name%$USER%g" ./hadoop_conf/hdfs-site.xml
cp ./hadoop_conf/hdfs-site.xml $HADOOP_HOME/etc/hadoop/
rm ./hadoop_conf/hdfs-site.xml

# core site not neede as default local file system only
cp ./hadoop_conf/mapred-site.xml $HADOOP_HOME/etc/hadoop/
cp ./hadoop_conf/yarn-site.xml $HADOOP_HOME/etc/hadoop/



#hdfs namenode -format
#start-dfs.sh
#
#jps
