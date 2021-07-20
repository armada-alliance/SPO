#!/bin/bash

###############################################################################
## Sucks in the Armada Alliance topology.json file and cncli pings all nodes ##
###############################################################################

ADDRESSES="$(curl -s https://armada-alliance.com/topology.json | jq '.[] | [.addr,.port,.ticker] | map_values(tostring) | join(" ")')"

if [[ -n "$ADDRESSES" ]]; then
    echo -e "\n$(date +%c) Pinging Topology"

    echo $ADDRESSES |
    while read -r -d '"' line
    do
        if [[ -n "$line" ]]; then
            XX=($line)
            echo -e "\n${XX[2]}"
            cncli ping --host ${XX[0]} --port ${XX[1]}
        fi
    done

    echo -e "\n$(date +%c) Finished"
fi
