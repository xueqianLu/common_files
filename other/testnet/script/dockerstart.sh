#!/bin/bash
source env.sh
docker pull xueqianlu/hashrs:latest
docker tag xueqianlu/hashrs:latest hashrs/hashrsd:latest

docker run -itd --privileged=true --restart=always -v $hd_dir:/root/.hashrsd -p 26657:26657 -p 26656:26656 -p $GRPC_PORT:26680 --name $CONTAINER_NAME hashrs/hashrsd:latest start --pruning=nothing --rpc.laddr tcp://0.0.0.0:26657  --rpc.unsafe --rpc.grpc_laddr tcp://0.0.0.0:26680 --p2p.seeds $NETWORK_SEEDS --log_level "*:info" --trace
