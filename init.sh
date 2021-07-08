#!/bin/bash
set -e

#INSTALL_DIR="/opt/bigdata/hive"
USER=`whoami`

JAVA_V="/usr/lib/jvm/java-8-openjdk-amd64"
HADOOP_V=`cat versions.txt | grep 'hadoop'| cut -d '=' -f '2'`
HIVE_V=`cat versions.txt | grep 'hive'| cut -d '=' -f '2'`
SPARK_V=`cat versions.txt | grep 'spark'| cut -d '=' -f '2'`
SCALA_V=`cat versions.txt | grep 'scala'| cut -d '=' -f '2'`

DOWNLOAD_DIR="/home/$USER/bigdata-downloads"
INSTALL_DIR="/home/$USER/bigdata-installation"
DATA_DIR="/home/$USER/bigdata-data"

HIVE_DIR="$INSTALL_DIR/hive"
HADOOP_DIR="$INSTALL_DIR/hadoop"
SPARK_DIR="$INSTALL_DIR/spark"

SPARK_HADOOP_V="3.2" #[2.7,3.2]
#SPARK_SCALA_V="-scala-$SCALA_V"
SPARK_SCALA_V=""
#-scala-2.12

HADOOP_HOME="$HADOOP_DIR/hadoop-${HADOOP_V}"
HIVE_HOME="$HIVE_DIR/apache-hive-${HIVE_V}-bin"
SPARK_HOME="$SPARK_DIR/spark-${SPARK_V}-bin-without-hadoop$SPARK_SCALA_V"

#spark-2.4.8-bin-without-hadoop-scala-2.12.tgz
#hadoop-3.2.2.tar.gz
#kafka_2.12-2.8.0.tgz
#apache-hive-3.1.2-bin.tar.gz

mkdir -p $DOWNLOAD_DIR $DATA_DIR
mkdir -p $HIVE_DIR $HADOOP_DIR $SPARK_DIR

#echo "export HADOOP_OPTS=\"-Djava.library.path=$HADOOP_HOME/lib/native\"" >> ~/.bash_aliases

if [ ! -f /home/$USER/.bash_aliases ]; then
    echo "export JAVA_HOME=$JAVA_V" >> ~/.bash_aliases
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bash_aliases
    echo "export HADOOP_HOME=$HADOOP_HOME" >> ~/.bash_aliases
    #echo "export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native" >> ~/.bash_aliases
    echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >> ~/.bash_aliases
    #echo "export LD_LIBRARY_PATH=\$HADOOP_HOME/lib/native:\$LD_LIBRARY_PATH" >> ~/.bash_aliases
    #echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> ~/.bash_aliases
    #echo "export HADOOP_CLASSPATH=\$HADOOP_HOME/share/hadoop/tools/lib/*" >> ~/.bash_aliases
    echo "export HIVE_HOME=$HIVE_HOME" >> ~/.bash_aliases
    echo "export PATH=\$PATH:\$HIVE_HOME/bin" >>  ~/.bash_aliases
    #echo "export HADOOP_CLASSPATH=${HADOOP_CLASSPATH}:${HIVE_HOME}/lib/*" >> ~/.bash_aliases
    echo "export SPARK_HOME=$SPARK_HOME" >> ~/.bash_aliases
    #echo "export SPARK_CONF_DIR=\${SPARK_HOME}/conf" >> ~/.bash_aliases
    #echo "export SPARK_DIST_CLASSPATH=\$HADOOP_CONF_DIR:\$HADOOP_HOME/share/hadoop/tools/lib/*:\$HADOOP_HOME/share/hadoop/common/lib/*:\$HADOOP_HOME/share/hadoop/common/*:\$HADOOP_HOME/share/hadoop/hdfs:\$HADOOP_HOME/share/hadoop/hdfs/lib/*:\$HADOOP_HOME/share/hadoop/hdfs/*:\$HADOOP_HOME/share/hadoop/mapreduce/lib/*:\$HADOOP_HOME/share/hadoop/mapreduce/*:\$HADOOP_HOME/share/hadoop/yarn:\$HADOOP_HOME/share/hadoop/yarn/lib/*:\$HADOOP_HOME/share/hadoop/yarn/*" >> ~/.bash_aliases
    echo "export PATH=\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >> ~/.bash_aliases
    echo "export PYTHONPATH=\$(ZIPS=(\"\$SPARK_HOME\"/python/lib/*.zip); IFS=:; echo \"\${ZIPS[*]}\"):\$PYTHONPATH" >> ~/.bash_aliases
fi

cat ~/.bash_aliases
source ~/.bash_aliases

echo "HADOOP_V : $HADOOP_V"
echo "HIVE_V : $HIVE_V"
echo "SPARK_V : $SPARK_V"
echo "SCALA_V : $SCALA_V"
echo "DOWNLOAD_DIR : $DOWNLOAD_DIR"
echo "INSTALL_DIR : $INSTALL_DIR"
echo "HADOOP_DIR : $HADOOP_DIR"
echo "HIVE_DIR : $HIVE_DIR"
echo "SPARK_DIR : $SPARK_DIR"
echo "HADOOP_HOME : $HADOOP_HOME"
echo "HIVE_HOME : $HIVE_HOME"
echo "SPARK_HOME : $SPARK_HOME"



