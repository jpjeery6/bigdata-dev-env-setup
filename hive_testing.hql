CREATE TABLE IF NOT EXISTS student(Student_Name STRING,Student_Rollno INT,Student_Marks FLOAT)ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

INSERT INTO TABLE student VALUES ('Dikshant',1,95),('Akshat', 2 ,96),('Dhruv',3,90);
INSERT INTO TABLE student VALUES ('Allu',4,78.5),('Ramu', 5 , 63),('Dinesh',6,93.5);

INSERT INTO TABLE id_table VALUES (95),(96),(90);

SELECT * FROM student;

spark-2.4.4-bin-hadoop2.7/bin/spark-shell \
  --jars `ls packaging/hudi-spark-bundle/target/hudi-spark-bundle_2.11-*.*.*-SNAPSHOT.jar` \
  --conf 'spark.serializer=org.apache.spark.serializer.KryoSerializer'

  --conf spark.sql.catalogImplementation=hive
  --driver-java-options  "-Dhive.metastore.uris=thrift://localhost:9083"

import org.apache.spark.sql.SparkSession;
import org.apache.spark.SparkConf;


val conf = new SparkConf().set("spark.sql.hive.metastore.version", "3.1.2").set("spark.sql.hive.metastore.jars", "path").set("spark.sql.hive.metastore.jars.path","file:///home/jp/bigdata/hive/apache-hive-3.1.2-bin/lib/*");
val newsp=SparkSession.builder().config(conf).enableHiveSupport().getOrCreate();

sc.getConf.get("spark.sql.warehouse.dir")
sc.getConf.get("spark.sql.catalogImplementation")

SPARK_SQL_CATALOGIMPLEMENTATION=hive
SPARK_SQL_WAREHOUSE_DIR=

-- spark.sql("CREATE TABLE IF NOT EXISTS student(Student_Name STRING,Student_Rollno INT,Student_Marks FLOAT)ROW FORMAT DELIMITED FIELDS TERMINATED BY ','").show()

-- spark.sql("INSERT INTO TABLE student VALUES ('Dikshant',1,95.5),('Akshat', 2 , 96),('Dhruv',3,90.5);").show()

-- spark.sql("SELECT * FROM student;").show()