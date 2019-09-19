#!/usr/bin/env bash

set -o errexit

sudo apt-get update
sudo apt-get install figlet --assume-yes

#
# Redis
#
figlet -f standard Redis

sudo apt-get install redis-server --assume-yes
# Ensure that Redis is working
redis-cli ping

#
# PostgreSQL
#
figlet -f standard PostgreSQL

sudo apt-get install postgresql-10 postgresql-contrib --assume-yes

sudo service postgresql stop

sudo sed -i -e "s/#listen_addresses = 'localhost'/listen_addresses = '0.0.0.0'/" /etc/postgresql/10/main/postgresql.conf
sudo sh -c 'echo "local all postgres peer" > /etc/postgresql/10/main/pg_hba.conf'
sudo sh -c 'echo "host all freefeed all trust" >> /etc/postgresql/10/main/pg_hba.conf'

#
# Re-create database with russian locale
sudo locale-gen ru_RU
sudo locale-gen ru_RU.UTF-8
sudo update-locale 

DB_DIR=/var/lib/postgresql/10/main
sudo rm -rf $DB_DIR
sudo mkdir $DB_DIR
sudo chown postgres:postgres $DB_DIR
sudo chmod 700 $DB_DIR
sudo -u postgres /usr/lib/postgresql/10/bin/initdb --encoding=utf-8 --locale=ru_RU.UTF-8 $DB_DIR
# Database is initialized
#

sudo service postgresql start

sudo -u postgres psql -c "create user freefeed with password 'freefeed';"
sudo -u postgres psql -c 'alter user freefeed with superuser;'

sudo -u postgres psql -c 'create database freefeed with owner freefeed;'
sudo -u postgres psql -c 'create database freefeed_test with owner freefeed;'

#
# All done
#
figlet -f standard "All done"
