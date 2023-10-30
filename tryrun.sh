#!/bin/bash
# eval cmd="$1" ==> error
#
tryrun(){
    eval cmd="\$1"
    interval=5

    # Timeout in seconds
    timeout=3600  # 1 hour

    # Get the start time
    start_time=$(date +%s)

    # Run the command repeatedly until the timeout is reached
    while true; do
        # Run the command
        if $cmd; then
            echo "Command ran successfully. Exiting."
            break
        fi

        # Check if the timeout has been reached
        current_time=$(date +%s)
        elapsed_time=$((current_time - start_time))
        if [ $elapsed_time -ge $timeout ]; then
            echo "Timeout reached. Exiting."
            break
        fi

        # Sleep for the specified interval
        sleep $interval
    done
}

# eval cmd="\$1"
# The @ variable is used to collect all the parameters
params="$@"
eval cmd="\$params"
echo "try to run $cmd"
#To pass a string that contains spaces as a single parameter to a shell command in a Unix-like environment (e.g., Bash), you should wrap the string in quotes. The most common practice is to use double quotes
tryrun "$cmd"
