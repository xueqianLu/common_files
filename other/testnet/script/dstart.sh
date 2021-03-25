#!/bin/bash
source env.sh

rm node-server-grpc.sock
hd start --pruning=nothing --rpc.unsafe --rpc.grpc_laddr $NODE_GRPC_ADDR --p2p.seeds $NETWORK_SEEDS --log_level "*:info" --trace > d.log 2>&1 &
