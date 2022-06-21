# Testnet baker setup

## Don't use this setup in production (unsecure key setup)
## Requirements (tested on Ubuntu 20.04LTS)

- [Docker engine](https://docs.docker.com/engine/install/)
- [Docker-compose](https://docs.docker.com/compose/install/)
- 50 / 60 GB free disk space
## Get faucet account

Follow instruction on [https://teztnets.xyz/jakartanet-faucet](https://teztnets.xyz/jakartanet-faucet) and download your faucet file inside this repository.

## Setup environment file

This script will activate your faucet account and create `.env` file ready to run next step.

```bash
# Set activate account script executable
chmod +x activate-account.sh
# Run setup
./activate-account.sh faucet.json
```

## Configuration

Inside newly created `.env` file you can find your faucet account information.
Edit `.env` file NODE_STORAGE to change storage blockchain storage path (use absolute path).

## Run Baking stack

Run docker-compose : 
```bash
docker-compose up -d
```

Node will download and sync tezos testnet (it take 4/5 hours depending your computer). And start baking blocks in some days (4 days).