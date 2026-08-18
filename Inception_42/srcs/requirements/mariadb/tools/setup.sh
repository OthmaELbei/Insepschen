#!/bin/bash

set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
       mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

service mariadb  start 

mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.*  TO '${MYSQL_USER}'@'%';"

mysql -e "FLUSH PRIVILEGES;"

service mariadb stop

exec mariadbd  --user=mysql