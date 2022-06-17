#!/bin/bash
echo "Take ownership of mounted path (dev purpose 777)"
sudo chmod -R 777 /mnt
sudo chmod -R 777 $TEZOS_HOME_CONFIG

if [ ! -f "$ID_FILE" ] ; then
    echo "Identity File not found :  Init configuration..."
    rm -f $TEZOS_HOME_CONFIG/config.json
    tezos-node config init --data-dir=$TEZOS_HOME_CONFIG --history-mode rolling --network=jakartanet --net-addr=0.0.0.0:$P2P_PORT --rpc-addr=127.0.0.1:$RPC_PORT --rpc-addr=0.0.0.0:$RPC_PORT --allow-all-rpc=0.0.0.0:$RPC_PORT
    echo "Get snapshot for testnet"
    if [ $USE_SNAPSHOT = "true"]
    then
        echo "Snapshot unavailable for jakartanet"
        # if test -f "$FILE" ; then
        #     echo "Snapshot $FILE aleady download"
        # else
        #     wget $SNAPSHOT_URL -O $FILE
        #     # Redo permissions to be able to delete file from outside of container
        # fi
        # echo "Init tezos-node for testnet & import snapshot"
        # # tezos-node config init --network=hangzhounet
        # sudo chmod -R 777 /mnt 
        # tezos-node snapshot import $FILE
    fi
fi
echo "Run tezos node"
tezos-node run --data-dir=$TEZOS_HOME_CONFIG