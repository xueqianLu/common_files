#!/bin/bash
source env.sh
export pubkey=`hd hashgraph show-validator`
echo "pubkey=$pubkey"
valoper=`hcli query staking validators| grep -B1 $pubkey | grep -Eo "hashrsvaloper[0-9a-z]+"`
echo "valoper=$valoper"
