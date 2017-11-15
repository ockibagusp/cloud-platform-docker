#!/bin/bash

# TODO on keyboard interrupt: stop server

set -e

if [ "$ENV" = 'DEV' ]; then
    echo "Running Development Server on port 8000"
    source /projects/venv/bin/activate && \
        python /projects/django/manage.py runserver 0.0.0.0:8000
else
    echo "Container not running in development mode. Please create new container with ENV=DEV!"
fi