#!/usr/bin/env bash
# Configure script runtime settings
set -o errexit -o pipefail -o nounset
#set -o xtrace

# Updating packages
echo Applying pending updates...
yum update -y

# Install common packages
yum install -y jq


amazon-linux-extras install -y epel
yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
yum install -y mysql-community-server

service mysqld start

AUTO_GENERATED_PASSWORD=$(sudo grep 'temporary password' /var/log/mysqld.log | sed 's/.* //')
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" > /tmp/mysql-init.sql
mysql --connect-expired-password -u root -p$AUTO_GENERATED_PASSWORD < /tmp/mysql-init.sql
rm -rf /tmp/mysql-init.sql

chkconfig mysqld on

