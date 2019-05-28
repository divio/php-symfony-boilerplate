#!/bin/bash

if [ ! -f /app/vendor/autoload.php ]; then
    composer install
fi
