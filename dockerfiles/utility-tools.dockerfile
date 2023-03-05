# Utility Tools Containers

# -----------------------------------------------------------------
# Composer
# -----------------------------------------------------------------
FROM composer:latest as composer

WORKDIR /var/www/html/backend

# -----------------------------------------------------------------
# Node JS or NPM
# -----------------------------------------------------------------

FROM node:18.14.0-alpine3.17 as node

WORKDIR /var/www/html/backend
