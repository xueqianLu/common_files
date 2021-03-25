#!/bin/bash
source env.sh
tail -f `docker inspect --format='{{.LogPath}}' $CONTAINER_NAME`
