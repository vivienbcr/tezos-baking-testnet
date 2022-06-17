# Testnet baker setup

## Don't use this setup in production (unsecure key setup)
## Requirements

- Docker-compose
- Tezos-client 

## Get faucet account

Follow instruction on [https://teztnets.xyz/jakartanet-faucet](https://teztnets.xyz/jakartanet-faucet)

Usually after registration your tezos-client should have registred your key and account.
If you use command `tezos-client list known addresses` you will see faucet account.

```bash
➜ tezos-client list known addresses
Warning:
  
                 This is NOT the Tezos Mainnet.
  
           Do NOT use your fundraiser keys on this network.

faucet: tz1eJa8fZRorG4j1N9aLF4znkVQfZeBEtqzK (unencrypted sk known)
```

## Register as delegate

To become baker you should call it on network with following command : 

```bash
➜  tezos-client --endpoint https://rpc.jakartanet.teztnets.xyz register key faucet as delegate
Warning:
  
                 This is NOT the Tezos Mainnet.
  
           Do NOT use your fundraiser keys on this network.

Waiting for the node to be bootstrapped...
Current head: BMZS5hqQ8ZiK (timestamp: 2022-06-17T14:14:26.000-00:00, validation: 2022-06-17T14:14:30.205-00:00)
Node is bootstrapped.
Estimated storage: no bytes added
Estimated gas: 1000 units (will add 0 for safety)
Estimated storage: no bytes added
Operation successfully injected in the node.
Operation hash is 'ooBwwQ4LcJAr8oRNDFTBStZ7DfaCUygnEyUDCYYNNRFgeRZXfki'
Waiting for the operation to be included...
Operation found in block: BLG2NcQpZtfcG2wBLSSV4g5naxUop4Sop9K1wZ43zxEkzmHHncQ (pass: 3, offset: 0)
This sequence of operations was run:
  Manager signed operations:
    From: tz1eJa8fZRorG4j1N9aLF4znkVQfZeBEtqzK
    Fee to the baker: ꜩ0.000359
    Expected counter: 305863
    Gas limit: 1000
    Storage limit: 0 bytes
    Balance updates:
      tz1eJa8fZRorG4j1N9aLF4znkVQfZeBEtqzK ... -ꜩ0.000359
      payload fees(the block proposer) ....... +ꜩ0.000359
    Revelation of manager public key:
      Contract: tz1eJa8fZRorG4j1N9aLF4znkVQfZeBEtqzK
      Key: edpkuGSuoaUP3F9q1Saa7roj1uzMm1dCc5ZQT94SWnRWnB3ZjJVvjh
      This revelation was successfully applied
      Consumed gas: 1000
  Manager signed operations:
    From: tz1eJa8fZRorG4j1N9aLF4znkVQfZeBEtqzK
    Fee to the baker: ꜩ0.000252
    Expected counter: 305864
    Gas limit: 1000
    Storage limit: 0 bytes
    Balance updates:
      tz1eJa8fZRorG4j1N9aLF4znkVQfZeBEtqzK ... -ꜩ0.000252
      payload fees(the block proposer) ....... +ꜩ0.000252
    Delegation:
      Contract: tz1eJa8fZRorG4j1N9aLF4znkVQfZeBEtqzK
      To: tz1eJa8fZRorG4j1N9aLF4znkVQfZeBEtqzK
      This delegation was successfully applied
      Consumed gas: 1000

The operation has only been included 0 blocks ago.
We recommend to wait more.
Use command
  tezos-client wait for ooBwwQ4LcJAr8oRNDFTBStZ7DfaCUygnEyUDCYYNNRFgeRZXfki to be included --confirmations 1 --branch BLUb6bBmLrEw9zLaiFvnzyaqR4NWFg32bKEQeaW5HgJbJW5DoWL
and/or an external block explorer.
```

## Run servers

Before run docker-compose you should set faucet private key as varriable in `docker-compose.yml` file.

```yaml
  tezos-signer:
    hostname: signer
    image: tezos/tezos:v13.0
    restart: always
    volumes:
      - ./scripts:/mnt
    depends_on:
      - tezos-node
    entrypoint: [ "/bin/sh", "/mnt/signer-start.sh" ]
    environment:
      - SIGNER_PORT=7000
      - BAKER_SECRET_KEY=unencrypted:PUT_YOUR_FAUCET_PRIVATE_KEY_HERE
```

Run docker-compose : 
```bash
docker-compose up -d
```

Node will download and sync tezos testnet (it take 4/5 hours depending your computer).