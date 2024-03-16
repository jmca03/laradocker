#! /bin/sh

mkdir -p /var/log
mkdir -p /var/log/cron
mkdir -p /var/log/supervisor

touch /var/log/cron/cron.log 
touch /var/log/supervisor/supervisord.log
touch /var/log/supervisor/laravel-queue.log

crond -b

supervisord -c /etc/supervisor/supervisord.conf

ssh-keygen -qA
/usr/sbin/sshd -D

su ${CONTAINER_USER}