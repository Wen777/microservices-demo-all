#!/bin/sh
set -e

if [ "${1:0:1}" = '-'  ]; then
        set -- java -Djava.security.egd=file:/dev/urandom -jar ./app.jar --port=80  "$@" && telegraf --config /etc/telegraf.conf 
    fi

    exec "$@" && telegraf --config /etc/telegraf.conf 

