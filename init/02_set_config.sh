#!/bin/bash
set -e

RIAK_EXPLORER_DEVELOPMENT_MODE=${RIAK_EXPLORER_DEVELOPMENT_MODE:-on}
RIAK_EXPLORER_PORT=${RIAK_EXPLORER_PORT:-9000}
RIAK_EXPLORER_NODE_NAME=${RIAK_EXPLORER_NODE_NAME:-riak_explorer}
RIAK_IFACE=${RIAK_IFACE:-eth0}

IP_ADDRESS=$(ip -o -4 addr list $RIAK_IFACE | awk '{print $4}' | cut -d/ -f1 2> /dev/null)
RIAK_NODE_NAME=${RIAK_NODE_NAME:-riak_member}
RIAK_NODE=${RIAK_NODE:-$RIAK_NODE_NAME@$IP_ADDRESS}

echo "nodename = ${RIAK_EXPLORER_NODE_NAME}@${IP_ADDRESS}" | tee -a ${RIAK_EXPLORER_CONFIG}
echo "clusters.default.development_mode = ${RIAK_EXPLORER_DEVELOPMENT_MODE}" | tee -a ${RIAK_EXPLORER_CONFIG}
echo "listener = 0.0.0.0:${RIAK_EXPLORER_PORT}" | tee -a ${RIAK_EXPLORER_CONFIG}
echo "platform_log_dir = ${RIAK_EXPLORER_LOGS}" | tee -a ${RIAK_EXPLORER_CONFIG}
echo "clusters.default.riak_node = ${RIAK_NODE}" | tee -a ${RIAK_EXPLORER_CONFIG}
#echo "log.syslog = on" | tee -a ${RIAK_EXPLORER_CONFIG}

echo $RIAK_NODE > /tmp/rr

if [ -s $RIAK_EXPLORER_USER_CONFIG ]; then
    cat $RIAK_EXPLORER_USER_CONFIG | tee -a ${RIAK_EXPLORER_CONFIG}
fi
