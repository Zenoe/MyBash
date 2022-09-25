#!/usr/bin/env sh

cd `dirname $0`
CUR_DIR=`pwd`

. $CUR_DIR/tool.sh
. $CUR_DIR/watchFile.sh

watchNRun '/root/work/rf/rf/lib/DutLibrary/Judge/DutGetShow.py' 'bash ./extractShowKey.sh'
