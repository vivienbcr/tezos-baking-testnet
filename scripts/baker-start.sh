#!/bin/bash
echo "Start baking process .. "
sleep 10
tezos-baker-013-PtJakart -R http://signer:$SIGNER_PORT --endpoint http://node:$NODE_PORT run with local node /home/tezos/.tezos-node --liquidity-baking-toggle-vote on 