#!/bin/sh
echo "--------------START SERVICE-----------------"
nohup /bin/telegraf --config ./telegraf.conf &>telegraf.log &
npm start
