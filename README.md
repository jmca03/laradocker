## Laradocker

    A Dockerized Laravel Application

## .env

    DB_CONNECTION=mysql
    DB_HOST=mysql
    DB_PORT=3306
    DB_DATABASE=homestead
    DB_USERNAME=homestead
    DB_PASSWORD=secret

    MONGODB_CONNECTION=mongodb
    MONGODB_HOST=mongodb
    MONGODB_PORT=27017
    MONGODB_USERNAME=homestead
    MONGODB_PASSWORD=secret

    REDIS_HOST=redis
    REDIS_PASSWORD=
    REDIS_PORT=6379

## PHP

    version: 8.2.2
    port: 9000
    dockerfile: ./dockerfiles/php.dockerfile
    target: base

    Artisan Command
        artisan:
        entrypoint:
        command: docker-compose run --rm artisan command_here...
        context php artisan command_here...

## MySQL

    version:8.0.32
    port: 3306

    credentials:
        root_password: secret
        default_database: homestead
        username: homestead
        password: secret

## MongoDB

    version:6.0.4
    port: 27017

    credentials:
        username: homestead
        password: secret

## REDIS

    version: latest
    port: 6379

## Composer

    version: latest
    dockerfile: ./dockerfiles/utility-tools.dockerfile
    target: composer
    command: docker-compose run --rm composer command_here...
    context: composer --ignore-platform-reqs command_here...

    Custom Dockerfile Command:
        create-laravel-app:
        command: docker-compose run --rm create-laravel-app
        context: composer --ignore-platform-reqs create-project laravel/laravel:^9.0 .

        install-mongodb-package:
        command: docker-compose run --rm install-mongodb-package
        context: composer --ignore-platform-reqs require jenssegers/mongodb:^3.9

## NPM

    version: 18.14.0
    dockerfile: ./dockerfiles/utility-tools.dockerfile
    target: node
    command: docker-compose run --rm npm command_here...
