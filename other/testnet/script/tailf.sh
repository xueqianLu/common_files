#!/bin/bash
source env.sh
now=`date +%s`
docker logs -f -t --since="$now" $CONTAINER_NAME
