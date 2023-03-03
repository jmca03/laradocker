FROM php:8.2.2-fpm-alpine3.17 as base

WORKDIR /var/www/html

# RUN adduser --disabled-password --home "/var/www/html" --uid "1000" noc
# # RUN addgroup -g 1000 noc
# RUN addgroup noc noc

COPY --chown=www-data:www-data /src .

# Update and Upgrade Alpine Linux package
RUN apk update && apk upgrade
# Add Necessary package to use pcl
RUN apk add --no-cache php81-pear php81-dev gcc musl-dev make supervisor

COPY --chown=www-data:www-data ./service.configurations/supervisord/supervisor.conf /etc/supervisor/conf.d

RUN supervisorctl reread
RUN supervisorctl update
RUN supervisorctl start laravel-worker:*

# Install PDO and PDO_Mysql
RUN docker-php-ext-install pdo pdo_mysql
# Install and enable mongodb extension
RUN pecl install  mongodb && docker-php-ext-enable mongodb 
# Install and enable redis extension
RUN pecl install redis && docker-php-ext-enable redis

RUN touch /var/www/html/storage/logs/laravel.log
RUN chown -R www-data:www-data /var/www/html/storage/logs/laravel.log

RUN touch /var/www/html/storage/logs/worker.log
RUN chown -R www-data:www-data /var/www/html/storage/logs/worker.log

RUN chown -R www-data:www-data /var/www

EXPOSE 9000

FROM base as artisan
ENTRYPOINT [ "php", "artisan" ]