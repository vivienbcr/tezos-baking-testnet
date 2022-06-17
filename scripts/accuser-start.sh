#!/bin/bash
echo "Start acuser process .. "
sleep 10
tezos-accuser-013-PtJakart -R http://signer:$SIGNER_PORT --endpoint http://node:$NODE_PORT run