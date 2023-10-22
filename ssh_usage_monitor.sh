#!/bin/bash

# Create an initial empty SSH_Usage.json if it doesn't exist
if [ ! -f SSH_Usage.json ]; then
    echo '[]' > SSH_Usage.json
fi

while true; do
    # Capture the nethogs output into a temporary file
    rm -f nethogs_output.txt
    sudo timeout 58s stdbuf -o0 nethogs -j > nethogs_output.txt
    
    # Process the output to obtain summed values for each user
    new_data=$(awk '/{/{flag=1} flag' nethogs_output.txt | jq -s -c '[flatten | group_by(.name) | .[] | select(.[0].name | contains("sshd")) | {name: .[0].name, RX: map(.RX) | add, TX: map(.TX) | add}]')
    
    # Merge the new data with the existing aggregated usage
    jq -s '.[0] as $original | .[1] as $new | ($original + $new) | group_by(.name) | map({name: .[0].name, RX: map(.RX) | add, TX: map(.TX) | add})' SSH_Usage.json <(echo "$new_data") > temp_output.json
    
    # Move the temporary file to be the new SSH_Usage.json
    mv temp_output.json SSH_Usage.json
    sleep 2
done
