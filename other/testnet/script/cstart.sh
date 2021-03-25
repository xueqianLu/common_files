#!/bin/bash
source env.sh

hcli rest-server --laddr "tcp://0.0.0.0:8545" --grpc-node tcp://127.0.0.1:$GRPC_PORT --chain-id $CHAINID --trace > c.log 2>&1 &
#hcli rest-server --laddr "tcp://0.0.0.0:8545" --unlock-key admin --grpc-node tcp://127.0.0.1:$GRPC_PORT --chain-id $CHAINID --trace
