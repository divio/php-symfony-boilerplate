#!/bin/bash
. $(dirname "$0")/ensure-env.sh
php /app/bin/console server:run *:80
