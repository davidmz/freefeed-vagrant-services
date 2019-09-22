#!/usr/bin/env bash

set -o errexit

# Becaming root
if [ ! $UID -eq 0 ]; then
  echo "RESTARTING AS ROOT"
  exec sudo "$0"
fi


apt-get update
apt-get install figlet --assume-yes

# Adjusting time
timedatectl set-ntp on
systemctl restart systemd-timesyncd

#
# Redis
#
figlet -f standard Redis

apt-get install redis-server --assume-yes
# Ensure that Redis is working
redis-cli ping

#
# PostgreSQL
#
figlet -f standard PostgreSQL

PG_VERSION=11
PG_DATA_DIR="/var/lib/postgresql/$PG_VERSION/main"
PG_CONF_DIR="/etc/postgresql/$PG_VERSION/main"

echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update

apt-get install "postgresql-$PG_VERSION" postgresql-contrib --assume-yes

service postgresql stop

sed -i -e "s/#listen_addresses = 'localhost'/listen_addresses = '0.0.0.0'/" "$PG_CONF_DIR/postgresql.conf"
# sh << END
echo "local all postgres peer" > "$PG_CONF_DIR/pg_hba.conf"
echo "host all freefeed all trust" >> "$PG_CONF_DIR/pg_hba.conf"
# END

#
# Re-create database with russian locale
locale-gen ru_RU
locale-gen ru_RU.UTF-8
update-locale 

rm -rf $PG_DATA_DIR/*
sudo -u postgres "/usr/lib/postgresql/$PG_VERSION/bin/initdb" --encoding=utf-8 --locale=ru_RU.UTF-8 "$PG_DATA_DIR"
# Database is initialized
#

service postgresql start

sudo -u postgres psql << END
create user freefeed with password 'freefeed';
alter user freefeed with superuser;
create database freefeed with owner freefeed;
create database freefeed_test with owner freefeed;
END

#
# All done
#
figlet -f standard "All done"
