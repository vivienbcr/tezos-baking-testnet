#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Faucet file should be provided as first argument, like './activate-account.sh faucet.json'"
    exit 1
fi
FILE=$1
if [ ! -f "$FILE" ]; then
    echo "$FILE file does not exist."
fi
echo "Activate account, it will take some time..."
PRIV_KEY=$(docker run --entrypoint /bin/sh -v $(pwd)/$FILE:/temp/faucet.json -e TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=Y tezos/tezos:v13.0 -c "sudo apk add jq > /dev/null \
    && tezos-client -E https://rpc.jakartanet.teztnets.xyz activate account faucet with /temp/faucet.json &> /dev/null \
    && cat /home/tezos/.tezos-client/secret_keys | jq -r '.[] | select(.name==\"faucet\") | .value' ")

echo "Private key exported, wait for public key hash..."
PUB_KEY=$(docker run --entrypoint /bin/sh -v $(pwd)/$FILE:/temp/faucet.json -e TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=Y tezos/tezos:v13.0 -c "sudo apk add jq > /dev/null \
    && tezos-client import secret key faucet $PRIV_KEY &> /dev/null \
    && cat /home/tezos/.tezos-client/public_key_hashs | jq -r '.[] | select(.name==\"faucet\") | .value' ")

echo "Public key hash exported, create .env file..."

echo "NODE_STORAGE_PATH=./data/.tezos-node" >> .env
echo "BAKER_SECRET_KEY=$PRIV_KEY" >> .env
echo "BAKER_PUB_KEY_HASH=$PUB_KEY" >> .env

echo "Set faucet account delegated to self"

docker run --entrypoint /bin/sh -v $(pwd)/$FILE:/temp/faucet.json -e TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=Y tezos/tezos:v13.0 -c "sudo apk add jq > /dev/null \
    && tezos-client import secret key faucet $PRIV_KEY &> /dev/null \
    && tezos-client --endpoint https://rpc.jakartanet.teztnets.xyz register key faucet as delegate"

echo "Done."