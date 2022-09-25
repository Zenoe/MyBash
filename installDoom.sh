dorunning()
{
    # first parameter is a string seperated by space, so need to be treated differently
    eval cmd="$1"
    tryTime="$2"
    if [ -z $tryTime ]; then
        tryTime=1
    fi

    echo $cmd
    x=1
    while [ $x -le $tryTime ]
    do
        echo "running $x times"
        x=$(( $x + 1 ))
        eval ${cmd}
        res=$?
        if [ $res -eq 0 ]; then
            return 0
            break;
        fi
    done
    return 1
}

echo 'begin to run'
cmd="/root/.emacs.d/bin/doom install"
dorunning  "\${cmd}" 5
