FROM php:8.1-fpm

WORKDIR /var/www/html/backend

COPY src .

RUN apt-get update && apt-get upgrade

RUN apt-get install -y supervisor systemctl cron

# Install PDO and PDO_Mysql
RUN docker-php-ext-install pdo pdo_mysql
# Install and enable mongodb extension
RUN pecl install  mongodb && docker-php-ext-enable mongodb 
# Install and enable redis extension
RUN pecl install redis && docker-php-ext-enable redis

COPY ./config/supervisord/supervisord.conf /etc/supervisor/supervisord.conf

WORKDIR /var/www/html

COPY ./config/build.sh .

COPY ./config/crontab/root /etc/cron.d/root

RUN crontab /etc/cron.d/root

RUN touch /var/log/cron.log

RUN chmod 755 build.sh

WORKDIR /var/www/html/backend

RUN touch storage/logs/laravel.log
RUN chown -R www-data /var/www/html/backend
RUN chown -R www-data /var/www/html/backend/storage/logs
RUN chown -R www-data /var/www/html/backend/storage/logs/laravel.log


EXPOSE 9000

CMD [ "/bin/bash", "-c", "/var/www/html/build.sh" ]