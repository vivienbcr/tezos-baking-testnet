#!/bin/bash
echo "Take ownership of mounted path (dev purpose 777)"
sudo chmod -R 777 /mnt
sudo chmod -R 777 $TEZOS_HOME_CONFIG

if [ ! -f "$ID_FILE" ] ; then
    echo "Identity File not found :  Init configuration..."
    rm -f $TEZOS_HOME_CONFIG/config.json
    tezos-node config init --data-dir=$TEZOS_HOME_CONFIG --history-mode rolling --network=jakartanet --net-addr=0.0.0.0:$P2P_PORT --rpc-addr=0.0.0.0:$RPC_PORT --allow-all-rpc=0.0.0.0:$RPC_PORT
    echo "Get snapshot for testnet"
    if [ $USE_SNAPSHOT = "true"]; then
        echo "TODO: Snapshot unavailable yet for jakartanet"
    fi
fi
echo "Run tezos node"
tezos-node run --data-dir=$TEZOS_HOME_CONFIG