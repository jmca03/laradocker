# Utility Tools Containers

# -----------------------------------------------------------------
# Composer
# -----------------------------------------------------------------
FROM composer:latest as composer

WORKDIR /var/www/html

ENTRYPOINT [ "composer", "--ignore-platform-reqs" ]

# Create Laravel 9 Application
FROM composer as create-laravel-app

CMD [ "composer", "--ignore-platform-reqs", "create-project", "laravel/laravel:^9.0", "." ]

# Install Jenssegers Package
FROM composer as install-mongodb-package

CMD [ "composer", "--ignore-platform-reqs", "require", "jenssegers/mongodb:^3.9" ]

# -----------------------------------------------------------------
# Node
# -----------------------------------------------------------------

FROM node:18.14.0-alpine3.17 as node

WORKDIR /var/www/html

ENTRYPOINT [ "npm" ]
