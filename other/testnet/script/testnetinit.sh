#!/bin/bash
source env.sh
hcli config keyring-backend file 
hcli config chain-id $CHAINID
hcli config output json 
hcli config indent true 
hcli config trust-node true
hcli keys add admin <<EOM
bc123456
bc123456
EOM

hd init bitc-testnet --chain-id $CHAINID 
cp genesis.json $hd_dir/config/


