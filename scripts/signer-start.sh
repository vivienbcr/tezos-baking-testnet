#!/bin/bash
tezos-signer import secret key baker $BAKER_SECRET_KEY --force
tezos-signer launch http signer -p $SIGNER_PORT