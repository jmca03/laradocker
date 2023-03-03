FROM composer:latest as base-composer

WORKDIR /var/www/html

ENTRYPOINT [ "composer", "--ignore-platform-reqs" ]

# Create Laravel 9 Application
FROM base-composer as create-laravel-app

CMD [ "composer", "--ignore-platform-reqs", "create-project", "laravel/laravel:^9.0", "." ]

# Install Jenssegers Package
FROM base-composer as install-mongodb-package

CMD [ "composer", "--ignore-platform-reqs", "require", "jenssegers/mongodb:^3.9" ]