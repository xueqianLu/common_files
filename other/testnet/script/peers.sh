#!/bin/bash
curl -sX GET 'http://127.0.0.1:26657/net_info' | jq -r .result.n_peers
