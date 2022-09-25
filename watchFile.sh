#!/bin/bash
# watch for file change and execute a certain command

# eval cmd="$2" ==> error

watchNRun(){
    filePath=$1
    eval cmd="\${2}"

    ### Set initial time of file
    LTIME=`stat -c %Z $filePath`

    while true
    do
        ATIME=`stat -c %Z $filePath`

        if [[ "$ATIME" != "$LTIME" ]]
        then
            echo "RUN COMMAND"
            eval ${cmd}
            LTIME=$ATIME
        fi
        sleep 5
    done
}

# test
# filePath=$1
# eval cmd="\${2}"
# watchNRun $filePath $cmd
