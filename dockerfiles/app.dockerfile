# syntax=docker/dockerfile:1
FROM composer:lts as composer

FROM node:21.7.0-alpine3.19 as node

FROM php:8.3-fpm-alpine

ARG UID
ARG GID
ARG CONTAINER_USER
ARG CONTAINER_GROUP
ARG CONTAINER_PASSWORD

ENV CONTAINER_USER=${CONTAINER_USER}

WORKDIR /var/www/html

RUN apk update

RUN apk add vim

RUN apk add zip unzip openrc supervisor dcron openssh-server

RUN docker-php-ext-install mysqli pdo pdo_mysql
# RUN docker-php-ext-install pdo_pgsql
# RUN docker-php-ext-install pdo_sqlsrv

RUN apk add pcre-dev ${PHPIZE_DEPS}      \
    && pecl install mongodb redis         \
    && docker-php-ext-enable mongodb redis \
    && apk del pcre-dev ${PHPIZE_DEPS}

RUN addgroup -g ${GID} ${CONTAINER_GROUP}

RUN adduser -D --uid ${UID} \ 
    --ingroup ${CONTAINER_GROUP} \ 
    --shell /bin/sh ${CONTAINER_USER} \
    --home /home/${CONTAINER_USER}

RUN adduser ${CONTAINER_USER} www-data

RUN echo "${CONTAINER_USER}:${CONTAINER_PASSWORD}" | chpasswd

# RUN groupmod -g ${UID} www-data

COPY ./src .

RUN chown -R www-data:www-data /var/www/html/storage
RUN chown -R www-data:www-data /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage
RUN chmod -R 775 /var/www/html/bootstrap/cache

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/bin/npm /usr/local/bin/npm
COPY --from=node /usr/local/bin/npm /usr/local/bin/yarn

COPY ../config/cron /etc/cron.d/root
RUN crond -b

COPY ../config/supervisord.conf /etc/supervisor/supervisord.conf
COPY ../config/build.sh /var/www/build.sh

RUN chmod +x /var/www/build.sh

RUN touch /var/log/cron.log

RUN rc-update add supervisord default
RUN rc-update add dcron default

EXPOSE 9000

CMD [ "/bin/sh", "-c", "/var/www/build.sh" ]