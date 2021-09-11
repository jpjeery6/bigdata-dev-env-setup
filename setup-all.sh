#!/bin/bash
set -e

printf "\n\nCleaning up...\n\n"


if [ -f ~/.bash_aliases ]; then
    rm ~/.bash_aliases
fi
# Kill any running java processes
# java_processes=$(ps -ef | pgrep -f "java")
# printf "java processes = $java_processes"

# if [ -n "$java_processes" ]; then
#     kill -9 $java_processes
#     sleep 2000
# fi

printf "\n\n\nStarting Full Setup...\n\n\n"
. ./init.sh
# echo "Setting up Java..."
# . ./setup-java.sh
# echo "Setting up Mysql..."
# . ./setup-mysql.sh
printf "\n\nSetting up hadoop...\n\n"
. ./setup-hadoop.sh
printf "\n\nSetting up hive...\n\n"
. ./setup-hive.sh
printf "\n\nSetting up spark...\n\n"
. ./setup-spark.sh
#printf "\n\nSetup done. Running services...\n\n"
#. ./run-services.sh
printf "\n\nCompleted Successfully\n\n"