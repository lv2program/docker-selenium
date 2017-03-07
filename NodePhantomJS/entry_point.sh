#!/bin/bash

source /opt/bin/functions.sh

if [ -z "$HUB_ADDR" ]; then
  echo Not linked with a running Hub container 1>&2
  exit 1
fi

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

if [ -z "$IP" ]; then
  IP="$(hostname -i)"
fi


phantomjs --webdriver=$IP:$NODE_PORT ${PHANTOMJS_OPTS} --webdriver-selenium-grid-hub=http://$HUB_ADDR:$HUB_PORT

trap shutdown SIGTERM SIGINT
wait $NODE_PID
