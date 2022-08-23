#!/bin/bash
echo "Take ownership of mounted path (dev purpose 777)"
sudo chmod -R 777 /mnt
sudo chmod -R 777 $TEZOS_HOME_CONFIG
echo $TEZOS_HOME_CONFIG
if [ ! -f "$ID_FILE" ] ; then
    echo "Identity File not found :  Init configuration..."
    rm -rf $TEZOS_HOME_CONFIG
    tezos-node config init --data-dir=$TEZOS_HOME_CONFIG --history-mode rolling --network=https://teztnets.xyz/ghostnet --net-addr=0.0.0.0:$P2P_PORT --rpc-addr=0.0.0.0:$RPC_PORT --allow-all-rpc=0.0.0.0:$RPC_PORT
    if [ $USE_SNAPSHOT = "true" ] ; then
    echo "Get snapshot for testnet"
        wget https://ghostnet.xtz-shots.io/rolling -O tezos-ghostnet.rolling
        tezos-node snapshot import tezos-ghostnet.rolling --data-dir=$TEZOS_HOME_CONFIG
    fi
fi
echo "Run tezos node"
tezos-node run --data-dir=$TEZOS_HOME_CONFIG