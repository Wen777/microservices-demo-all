#!/bin/sh
echo "--------------START SERVICE-----------------"
/bin/telegraf --config ./telegraf.conf && npm start
