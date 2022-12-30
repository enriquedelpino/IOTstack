#!/bin/bash
set -e

# Set permissions
user="$(id -u)"
if [ "$user" = '0' -a -d "/data/nginx/proxy_host" ]; then

   echo "[IOTstack] begin self-repair"

   rsync -arpv --ignore-existing /${IOTSTACK_DEFAULTS_DIR}/ "/data/nginx/proxy_host"

   chown -Rc root:root /data

   echo "[IOTstack] end self-repair"
   
fi

exec "$@"

