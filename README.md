# riak-explorer on Docker

Standalone riak-explorer docker container. Bring your own riak cluster.

## Usage

#### Configuration

There are some configurable environmental variables that will set some riak settings. See [how the config is set](init/02_set_config.sh) for further explanation.

*  **`RIAK_EXPLORER_DEVELOPMENT_MODE`** (default: `on`)

    Set to `off` for production deployments.

    ```bash
    clusters.default.development_mode = ${RIAK_EXPLORER_DEVELOPMENT_MODE}
    ```

*  **`RIAK_EXPLORER_PORT`** (default: `9000`)

    The port to run on

    ```bash
    listener = 0.0.0.0:${RIAK_EXPLORER_PORT}
    ```

*  **`RIAK_NODE_NAME`** (default: `riak`)

    Name of riak node to connect to. Used when computing `RIAK_NODE`. Ignored if `RIAK_NODE` is specifed.

*  **`RIAK_IFACE`** (default: `eth0`)

    `RIAK_IFACE` is used to find the device that the `IP_ADDRESS` is pulled from, see `RIAK_NODE`.

*  **`RIAK_NODE`** (default: `${RIAK_NODE_NAME}@${IP_ADDRESS}`)

    Address of a riak node

    ```bash
    clusters.default.riak_node = ${RIAK_NODE}
    ```

    `IP_ADDRESS` is set to `ip -o -4 addr list $RIAK_IFACE | awk '{print $4}' | cut -d/ -f1)`.

*  **`RIAK_EXPLORER_USER_CONFIG`** (default: `/riak_explorer/etc/user.conf`)

    Path to a riak configuration file. This file will be appended to the end of the riak config file before start. These will overwrite anything defined in the main riak config file, including those set above via environmental variables.


#### Volumes

*  **`/var/log/riak_explorer`** - Logs from riak are **not** processed through `syslogd` and are **not** avaiable through `docker logs` (due to a bug in the riak_explorer binary distribution). Mount for logs file access.
