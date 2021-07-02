# odin-testnet-public-tools

# How to start with ODIN system

_Prerequisites: docker and docker-compose installed_

## Launching audit node

Clone this [repository](https://github.com/GeoDB-Limited/odin-testnet-public-tools).

The repository contains the docker-compose file for quick launching of the node with preconfigurations on rpc, and
genesis.json. Change your current directory to ```node``` <br>
Run startup bash script (for linux, mac):

```bash
./start.sh
```

It will start the light node for you, which will ingest all the previous heights

After node is launched, it starts syncing with network.

_Note: Check our nodes real-time logs with the following command:_

```docker-compose logs -f --tail 100 node```

**[IMPORTANT]** Wait for the node to catch up with the remotes, to query it or send transactions

## Becoming validator

First of all, you need to log into your docker container

```bash
docker exec -it node /bin/bash
```

Check your validator private and public key (keep them secret)

```bash
cat ~/.band/config/priv_validator_key.json
```

It will look something like this:

```json
{
  "address": "4174F0A75D7CDCFF479E20119AE075D10F929218",
  "pub_key": {
    "type": "tendermint/PubKeySecp256k1",
    "value": "A0LCeCUHNTPz3TZt4zkrugkLYkcN2gbMdjATpUzQ/3Rm"
  },
  "priv_key": {
    "type": "tendermint/PrivKeySecp256k1",
    "value": "qlkQMUr9ugbXvV62YmPa0HB9AA9FcppIrVmypTxskg8="
  }
}
```

Copy the "pub_key" value. You will need it in the form becoming a validator:
**Public key (base64)**

[Becoming validator](https://testnet.odinprotocol.io/validators)