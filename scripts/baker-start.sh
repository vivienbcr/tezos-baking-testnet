#!/bin/bash
echo "Start baking process .. "
sudo chown -R 100 /home/tezos/.tezos-client
sleep 15
tezos-client --remote-signer http://$SIGNER_URL import public key baker http://$SIGNER_URL/$PKH --force
tezos-baker-013-PtJakart -R http://$SIGNER_URL --endpoint http://$NODE_URL run with local node /home/tezos/.tezos-node --liquidity-baking-toggle-vote pass baker