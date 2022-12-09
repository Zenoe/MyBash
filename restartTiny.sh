#!/bin/bash

option=$1

cd `dirname $0`
CUR_DIR=`pwd`

. $CUR_DIR/tool.sh


if [ -z $option ]; then
    option='comment'
fi
echo $option
confFile=/etc/tinyproxy/tinyproxy.conf

if [ $option == "u" ]; then
    replace_str $confFile "#upstream http 127.0.0.1:7890" "upstream http 127.0.0.1:7890"
else
    replace_str $confFile "upstream http 127.0.0.1:7890" "#upstream http 127.0.0.1:7890"
fi

systemctl restart tinyproxy.service
