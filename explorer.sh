#!/bin/bash

# Ensure correct ownership and permissions on volumes
chown -R riak:riak ${RIAK_EXPLORER_LOGS}

exec /sbin/setuser riak "$(ls -d ${RIAK_EXPLORER_HOME}/erts*)/bin/run_erl" "/tmp/riak_explorer" "${RIAK_EXPLORER_LOGS}" "exec riak_explorer start"
