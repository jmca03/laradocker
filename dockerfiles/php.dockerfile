FROM php:8.1-fpm

WORKDIR /var/www/html/backend

COPY src .

RUN apt update && apt upgrade

# Install PDO and PDO_Mysql
RUN docker-php-ext-install pdo pdo_mysql
# Install and enable mongodb extension
RUN pecl install  mongodb && docker-php-ext-enable mongodb 
# Install and enable redis extension
RUN pecl install redis && docker-php-ext-enable redis

RUN apt install -y supervisor systemctl cron

COPY ./config/supervisord/supervisord.conf /etc/supervisor/supervisord.conf

WORKDIR /var/www/html

COPY ./config/start.sh .

COPY ./config/crontab/root /etc/cron.d/root

RUN crontab /etc/cron.d/root

RUN touch /var/log/cron.log

RUN chmod 755 start.sh

EXPOSE 9000

CMD [ "/bin/bash", "-c", "/var/www/html/start.sh" ]