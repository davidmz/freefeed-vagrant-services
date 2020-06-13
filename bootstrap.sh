#!/usr/bin/env bash

set -o errexit

# Becaming root
if [ ! $UID -eq 0 ]; then
  echo "RESTARTING AS ROOT"
  exec sudo "$0"
fi

apk update
apk upgrade

apk add nano figlet

# Adjust time
# For some reason constraints isnt working in this distro
# see https://gitlab.alpinelinux.org/alpine/aports/issues/9635
sed -i -e "s/constraints /#constraints /" /etc/ntpd.conf
sed -i -e "s/#NTPD_OPTS=/NTPD_OPTS=-s/" /etc/conf.d/openntpd
service openntpd restart

#
# Redis
#
figlet -f standard Redis

# Alpine 3.12 has Redis 5.0.9
# https://pkgs.alpinelinux.org/packages?name=redis&branch=v3.12
apk add redis
# Listen to all addresses
sed -i -e "s/bind 127.0.0.1/bind 0.0.0.0/" /etc/redis.conf
service redis start
# Test it
redis-cli ping
rc-update add redis default

#
# PostgreSQL
#
figlet -f standard PostgreSQL

# Alpine 3.12 has PostgreSQL 12.3
# https://pkgs.alpinelinux.org/packages?name=postgresql&branch=v3.12
apk add postgresql postgresql-contrib

sed -i -e "s/#initdb_opts=\"--locale=en_US.UTF-8\"/initdb_opts=\"--locale=en_US.UTF-8 --encoding=utf-8\"/" \
  /etc/conf.d/postgresql

service postgresql setup

sed -i -e "s/#listen_addresses = 'localhost'/listen_addresses = '0.0.0.0'/" \
  /etc/postgresql/postgresql.conf
echo "local all postgres peer" >> /var/lib/postgresql/12/data/pg_hba.conf
echo "host all freefeed all trust" >> /var/lib/postgresql/12/data/pg_hba.conf

service postgresql start
rc-update add postgresql default

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
