#!/bin/bash
source env.sh
pubkey=`hd hashgraph show-validator`
hcli tx staking create-validator --chain-id $CHAINID --amount 10000000bitc --pubkey $pubkey --moniker $stakingmoniker --commission-rate 0.1 --commission-max-rate 0.2 --commission-max-change-rate 0.01 --min-self-delegation 1 --from admin --node $NODE_1
