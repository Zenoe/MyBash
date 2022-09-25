#!/bin/bash

log_info()
{
    DATE_TIME=`date +'%Y-%m-%d %H:%M:%S.%N'`
    DATE_TIME23="${DATE_TIME:0:23}"
    printf "%-s%-s%-20s%-s%-s\n" "[INFO ][${DATE_TIME23}]" "[${INSTALL_LOG_NAME}]" "[${SELF_SHELL_NAME}" "] " "$*" | tee -a ${INSTALL_LOG_FILE}
}

log_error()
{
    DATE_TIME=`date +'%Y-%m-%d %H:%M:%S.%N'`
    DATE_TIME23="${DATE_TIME:0:23}"
    printf "%-s%-s%-20s%-s%-s\n" "[ERROR][${DATE_TIME23}]" "[${INSTALL_LOG_NAME}]" "[${SELF_SHELL_NAME}" "] " "$*" | tee -a ${INSTALL_LOG_FILE}
}

replace_str()
{
destfile=$1
delstr=$2
newstr=$3

sed --version > /dev/null 2>&1
if [ $? -ne 0 ]; then
  # not gnu sed
  sed  -i .bk "/$delstr/d" $destfile
else
  sed  -i "/$delstr/d" $destfile
fi

echo "$newstr" >> $destfile
}

