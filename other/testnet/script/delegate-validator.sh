#!/bin/bash
source env.sh
pubkey=`hd hashgraph show-validator`
valoper=`hcli query staking validators | grep -B1 $pubkey | grep -Eo "hashrsvaloper[0-9a-z]+"`
hcli tx staking delegate $validator 6000000bitc --from admin --node $NODE_1
