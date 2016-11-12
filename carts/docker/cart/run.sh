#!/bin/sh
set -e

if [ "${1:0:1}" = '-'  ]; then
        ./telegraf --config ./telegraf.conf > telegraf.log && set -- java -Djava.security.egd=file:/dev/urandom -jar ./app.jar --port=80  "$@"
    fi

    exec ./telegraf --config ./telegraf.conf > telegraf.log && "$@"
