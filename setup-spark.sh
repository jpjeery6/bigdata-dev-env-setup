#!/bin/bash
set -e

. ./init.sh

if [ -d "$SPARK_DIR" ]; then
  rm -rf $SPARK_DIR
  mkdir -p $SPARK_DIR
fi


#wgethttps://downloads.apache.org/spark/spark-$SPARK_V/spark-$SPARK_V-bin-hadoop$SPARK_HADOOP_V.tgz -P $DOWNLOAD_DIR/
tar -xzf $DOWNLOAD_DIR/spark-$SPARK_V-bin-without-hadoop$SPARK_SCALA_V.tgz -C $SPARK_DIR

# mysql connector jar for connecting to metastore
# --- works in ubuntu 18.04 only ---
# sudo apt install -y libmysql-java
# sudo ln -s /usr/share/java/mysql-connector-java.jar $SPARK_HOME/jars/mysql-connector-java.jar
# --- should work universally ---
MYSQL_VERSION=`mysql --version | cut -d ' ' -f 4|cut -d '-' -f 1`
ln -s $INSTALL_DIR/opt/mysql-connector-java-$MYSQL_VERSION.jar  $SPARK_HOME/jars/mysql-connector-java.jar

# for some reason spark-hive jar doesn't ship with spark distribution, so downloading it.
curl --progress-bar -L \
    "https://repo1.maven.org/maven2/org/apache/spark/spark-hive_${SCALA_V}/${SPARK_V}/spark-hive_${SCALA_V}-${SPARK_V}.jar" \
    --output "${SPARK_HOME}/jars/spark-hive_${SCALA_V}-${SPARK_V}.jar"

# config dynamic injection of user_name
cp ./spark_conf/spark-defaults.conf.template ./spark_conf/spark-defaults.conf
sed -i "s%user_name%$USER%g" ./spark_conf/spark-defaults.conf
cp ./spark_conf/spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf
rm ./spark_conf/spark-defaults.conf

cp ./hive_conf/hive-site.xml.template $SPARK_HOME/conf/hive-site.xml

cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh
echo "export JAVA_HOME=$JAVA_V" >> $SPARK_HOME/conf/spark-env.sh
#echo "export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop" >> $SPARK_HOME/conf/spark-env.sh
#HADOOP_CONF_DIR
echo "export SPARK_DIST_CLASSPATH=$($HADOOP_HOME/bin/hadoop classpath)" >> $SPARK_HOME/conf/spark-env.sh
#echo "export SPARK_DIST_CLASSPATH=\$HADOOP_CONF_DIR:\$HADOOP_HOME/share/hadoop/tools/lib/*:\$HADOOP_HOME/share/hadoop/common/lib/*:\$HADOOP_HOME/share/hadoop/common/*:\$HADOOP_HOME/share/hadoop/hdfs:\$HADOOP_HOME/share/hadoop/hdfs/lib/*:\$HADOOP_HOME/share/hadoop/hdfs/*:\$HADOOP_HOME/share/hadoop/mapreduce/lib/*:\$HADOOP_HOME/share/hadoop/mapreduce/*:\$HADOOP_HOME/share/hadoop/yarn:\$HADOOP_HOME/share/hadoop/yarn/lib/*:\$HADOOP_HOME/share/hadoop/yarn/*" >> ~/.bash_aliases
echo "SPARK_HOME=$SPARK_HOME" >> $HIVE_HOME/conf/hive-env.sh

# give spark jars to hive (for hive on spark)

cat <<'EOT' >> $HIVE_HOME/conf/hive-env.sh
SPARK_JARS=""
for jar in `ls $SPARK_HOME/jars`; do
  if ! echo $jar | grep -q 'slf4j\|mysql'; then
    SPARK_JARS=$SPARK_JARS,$SPARK_HOME/jars/$jar
  fi
done
VAR=${SPARK_JARS#?};
export HIVE_AUX_JARS_PATH=$VAR
echo $HIVE_AUX_JARS_PATH
EOT

#cat $HIVE_DIR/apache-hive-$HIVE_V-bin/conf/hive-env.sh


# ln -s $SPARK_DIR/spark-$SPARK_V-bin-hadoop$SPARK_HADOOP_V/jars/spark-network-common_2.11-2.2.0.jar /usr/local/hive/apache-hive-2.3.0-bin/lib/spark-network-common_2.11-2.2.0.jar
# ln -s $SPARK_DIR/spark-$SPARK_V-bin-hadoop$SPARK_HADOOP_V/jars/spark-core_2.11-2.2.0.jar /usr/local/hive/apache-hive-2.3.0-bin/lib/spark-core_2.11-2.2.0.jar
# ln -s $SPARK_DIR/spark-$SPARK_V-bin-hadoop$SPARK_HADOOP_V/jars/scala-library-2.11.8.jar /usr/local/hive/apache-hive-2.3.0-bin/lib/scala-library-2.11.8.jar


# start-master.sh
# start-worker.sh 
# start-slave.sh

#jps




