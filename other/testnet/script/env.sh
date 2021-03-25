#!/bin/bash
export hd_dir="/opt/obiwan/.hashrsd"
export hcli_dir="/opt/obiwan/.hashrscli"

shopt -s  expand_aliases
alias hcli="hashrscli --home=${hcli_dir}"
alias hd="hashrsd --home=${hd_dir}"

export GRPC_PORT=26680
export NODE_GRPC_ADDR="tcp://0.0.0.0:$GRPC_PORT"

export CHAINID=12069001
export MONIKER=bitc-testnet

export NODE_1="tcp://18.166.50.189:26657"
export NETWORK_SEEDS="bd8034e832a2afe6ab171b593de1fcccaab679f0@18.166.50.189:26656"
export CONTAINER_NAME=hashrsd

# custom define
stakingmoniker=testnet_node_9
