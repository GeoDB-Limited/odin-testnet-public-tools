# odin-testnet-public-tools

## Restarting audit node

Clone this [repository](https://github.com/GeoDB-Limited/odin-testnet-public-tools).



The repository contains the docker-compose file for quick launching of the node with preconfigurations on rpc, and
genesis.json. Change your current directory to ```node``` <br>
Run startup bash script (for linux, mac):

```bash
./start.sh
```

Run following commands (for windows):

```
docker-compose -f ./docker-compose.yaml up -d
```


_Prerequisites: make sure that the validator private key (**priv_validator_key.json**) and node id (**node_key.json**) files, are in node/config_

It will start the node for you, which will ingest all the previous heights

After node is launched, it starts syncing with the network.

_Note: Check our nodes real-time logs with the following command:_

```docker-compose logs -f --tail 100 node```

⚠ **[IMPORTANT]** Wait for the node to catch up with the remotes, to query it or send transactions

## Becoming validator

First of all, you need to log into your docker container

```bash
docker exec -it node /bin/bash
```

### Restoring wallet

Once logged in, you can use bandd CLI to restore your ODIN wallet address. Please make sure to keep your mnemonic safe!
(you can use --keyring-backend test with the following command, for testing purposes)

```bash
bandd keys add [[YOUR_WALLET_NAME]] --recover # e.g. user1
```

After that you will be asked to enter your mnemonic phrase. This will recover your wallet from mnemonic.