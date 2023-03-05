#! /bin/bash

supervisorctl reread
supervisorctl update
supervisorctl start laravel-worker:*