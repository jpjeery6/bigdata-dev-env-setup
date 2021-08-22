# Fast One Click Big data dev env setup in WSL

This sets up lightweight Spark, Hive (along with Hadoop) environment for traditional data warehouse. It is developed on Windows OS's WSL, which is again a lightweight linux system for PC user (almost 90% in India atleast I believe).

This is meant a to provide a great dev experience for learning data engineering hands on with WSL and VS Code.

## Install VS code in Windows

Install extension : https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl

Get theme : https://marketplace.visualstudio.com/items?itemName=liviuschera.noctis

Rest of the extensions need to be installed inside WSL

Java extension pack: 

Scala metals:

python extension pack:

## Setup and Execution
JDK (both 8 and 11), MySQL (for metastore), hadoop, hive, spark is setup via this repo.
Java 8 is needed by hive - Hive doesnot run on java 11 https://github.com/exasol/hadoop-etl-udfs/issues/59
also make sure to set project JDK as 8
Java 11 is required by RedHat's Java Language Server.


bash setup-all.sh

bash run-services.sh