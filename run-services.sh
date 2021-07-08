#!/bin/bash
set -e

. ./init.sh
#sudo service ssh start
sudo service mysql start
#start spark
${SPARK_HOME}/sbin/start-master.sh
${SPARK_HOME}/sbin/start-slave.sh spark://EPINHYDW0718.princeton.epam.com:7077
#start-all.sh
#hiveserver2 &
#nohup /path/to/your/script.sh > /dev/null 2>&1 &
nohup `hive --service metastore` > /dev/null 2>&1 &

#lsof -i :80

#--driver-java-options  "-Dhive.metastore.uris=thrift://localhost:9083"

#kill -9 $(ps -ef | pgrep -f "java")
#kill -9 $(ps -ef | pgrep -f "SparkSubmit")
#kill -9 $(ps -ef | pgrep -f "RunJar")