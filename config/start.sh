#! /bin/bash

systemctl start supervisor

# supervisorctl reread
# supervisorctl update
supervisorctl start laravel-worker:*

service cron start && tail -f /var/log/cron.log