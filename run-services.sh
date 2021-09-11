#!/bin/bash
set -e

. ./init.sh
#sudo service ssh start
sudo service mysql start
#start spark
${SPARK_HOME}/sbin/start-master.sh

master_address=$(curl -s http://localhost:8080 | grep -m1 'spark://' | grep -oP '(?<=at ).*?(?=</)')
echo "master_address = $master_address"
${SPARK_HOME}/sbin/start-slave.sh $master_address
#start-all.sh
#hiveserver2 &
#nohup /path/to/your/script.sh > /dev/null 2>&1 &
nohup `hive --service metastore` > /dev/null 2>&1 &

#lsof -i :80
${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties > /dev/null 2>&1 &
${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties > /dev/null 2>&1 &
#kafka-topics.sh --list --bootstrap-server localhost:9092

# ${KAFKA_HOME}/bin/kafka-topics.sh --create --topic quickstart-events --bootstrap-server localhost:9092
# ${KAFKA_HOME}/bin/kafka-topics.sh --describe --topic quickstart-events --bootstrap-server localhost:9092

# ${KAFKA_HOME}/bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092
# ${KAFKA_HOME}/bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092
#--driver-java-options  "-Dhive.metastore.uris=thrift://localhost:9083"

#kill -9 $(ps -ef | pgrep -f "java")
#kill -9 $(ps -ef | pgrep -f "SparkSubmit")
#kill -9 $(ps -ef | pgrep -f "RunJar")