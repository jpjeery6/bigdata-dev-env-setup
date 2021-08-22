CREATE DATABASE if not exists metastore_db;
CREATE USER if not exists 'APP'@'%' IDENTIFIED BY 'mine';
GRANT all on `metastore_db`.* to 'APP'@'%'; -- TODO give password here other wise it uses caching_sha2_password
-- ALTER USER 'APP'@'%' IDENTIFIED WITH mysql_native_password BY 'mine'; ## temporary solution
flush privileges;