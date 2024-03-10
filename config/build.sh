#! /bin/sh

mkdir /var/log
mkdir /var/log/cron
mkdir /var/log/supervisor

touch /var/log/cron/cron.log 
touch /var/log/supervisor/supervisord.log
touch /var/log/supervisor/laravel-queue.log

crond -b

supervisord -c /etc/supervisor/supervisord.conf