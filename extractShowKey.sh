#!/usr/bin/env sh

cd `dirname $0`
CUR_DIR=`pwd`

. $CUR_DIR/tool.sh

OUTPUT='./output'
mkdir -p $OUTPUT

filePath='/root/work/rf/rf/lib/DutLibrary/Judge/DutGetShow.py'

egrep '    def dut_get_show_.*\(self,.*):' $filePath > \
    ./$OUTPUT/dutgetshowfun.txt

echo $?
if [ -z $? ]; then
    log_error "grep from DutGetShow.py failed"
    exit 1
fi

# replace with 'show interfaces overlaytunnel num' form
# remove duplicate entries
# save to file 'showkeys.txt'
echo 'extract from dutgetshowfun.txt'
cat ./$OUTPUT/dutgetshowfun.txt | \
    sed -E 's/    def dut_get_(.*)\(.*/\1/' | \
    sed -E 's/_/ /g' | \
    awk '!seen[$0]++' > $OUTPUT/showkeys.txt
if [ $? -ne 0 ]; then
    log_error "extract from dutgetshowfun.txt failed: $ret"
    exit 1
fi

echo 'create cliData.js'

echo 'const allCliList=[' > cliData.js
while read -r i; do
    # echo ">>>>>>>>>>>>>$i"
    if [ "${i:0:1}" = "#" ] || [ -z "$i" ]; then
        # echo "continue: $i"
        continue
    fi
    # echo $i
    echo "'$i'," >> cliData.js
done < $OUTPUT/showkeys.txt

echo ']

export default allCliList' >> cliData.js

echo 'done'
mv cliData.js /root/lzy/zenoe1/front/src/pages/
cp /root/work/rf/rf/lib/DutLibrary/Judge/DutGetShow.py /root/lzy/zenoe1/backend/tool/script/
cd /root/lzy/zenoe1/ && bash deploy.sh
