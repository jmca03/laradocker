## Laradocker

    A Dockerized Laravel Application

## Pre-config

    Pre-configuration branch is only used if you want to create
    a laravel application without composer

    Instruction:

        1. Pull preconfig branch
        2. Run docker-compose run --rm create-laravel-app
        3. Run docker-compose run --rm install-mongodb-package

## Composer

    version: latest
    dockerfile: ./dockerfiles/utility-tools.dockerfile
    command: docker-compose run --rm composer command_here...

    Custom Dockerfile Command:
        create-laravel-app:
        command: docker-compose run --rm create-laravel-app
        context: composer --ignore-platform-reqs create-project laravel/laravel:^9.0 .

        install-mongodb-package:
        command: docker-compose run --rm install-mongodb-package
        context: composer --ignore-platform-reqs require jenssegers/mongodb:^3.9

## NPM

    version: 18.14.0
    os: alpine3.17
    docker-tag: 18.14.0-alpine3.17
    command: docker-compose run --rm npm command_here...
