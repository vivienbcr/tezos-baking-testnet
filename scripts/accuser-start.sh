#!/bin/bash
echo "Start acuser process .. "
sleep 15
tezos-client --remote-signer http://$SIGNER_URL import public key baker http://$SIGNER_URL/$PKH --force
tezos-accuser-013-PtJakart -R http://$SIGNER_URL --endpoint http://$NODE_URL run