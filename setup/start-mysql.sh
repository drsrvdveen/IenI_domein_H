#!/bin/bash
sudo sh -c 'mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld && mysqld_safe --datadir=/var/lib/mysql &'

while ! nc -z localhost 3306; do
  sleep 0.1
done

## Create 'user' and 'readonly' database users
sudo mysql -u root -e "\
CREATE USER IF NOT EXISTS 'user'@'localhost' IDENTIFIED BY 'password';\
CREATE USER IF NOT EXISTS 'readonly'@'localhost' IDENTIFIED BY 'password';\
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost';\
GRANT SELECT ON *.* TO 'readonly'@'localhost';\
";
