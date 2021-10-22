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

Run following commands (for windows):

```
docker-compose -f ./docker-compose.yaml down -v --remove-orphans

docker-compose -f ./docker-compose.yaml pull

docker-compose -f ./docker-compose.yaml up -d
```

For reporter (for windows):

```
docker-compose -f ./docker-compose-reporter.yaml pull

docker-compose -f ./docker-compose-reporter.yaml up -d
```

It will start the node for you, which will ingest all the previous heights

After node is launched, it starts syncing with network.

_Note: Check our nodes real-time logs with the following command:_

```docker-compose logs -f --tail 100 node```

⚠ **[IMPORTANT]** Wait for the node to catch up with the remotes, to query it or send transactions

## Becoming validator

⚠ **[IMPORTANT]** In order to be able to restart your node, do the following:

```bash
./export.sh
```

Now, in node/config you have 2 new files, priv_validator_key.json, node_key.json, please, make sure to save these files.

First of all, you need to log into your docker container

```bash
docker exec -it node /bin/bash
```

### Creating wallet

Once logged in, you can use bandd CLI to create a new ODIN wallet address. Please make sure to keep your mnemonic safe!
(you can use --keyring-backend test with the following command, for testing purposes)

```bash
bandd keys add [[YOUR_WALLET_NAME]] # e.g. user1
```

The output of this command should look like this:

```
- name: user1
  type: local
  address: odin1rcv2d9vljealh8z9sqtnw3ljjchn4k28cgyu7x
  pubkey: odinpub1addwnpepqtfj3p0ep5n4clla3gtd9a6czz9lytl59696mu4txx55375ald55c0jz2j9
  mnemonic: ""
  threshold: 0
  pubkeys: []


**Important** write this mnemonic phrase in a safe place.
It is the only way to recover your account if you ever forget your password.

man act ride inhale wall success example anxiety damp daring slogan still town smile frame ketchup resemble avocado stairs crater meat aim lumber grace
```

### Getting tokens

After you've created wallet, you need tokens there, for these purposes you can either send the following POST request

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"address":"<your-wallet>","denom":"loki"}' \
  https://node.testnet.odinprotocol.io/faucet/request
```

You will be provided with loki tokens.

### Checking balance

```
bandd query bank balances <you-wallet> --chain-id odin-testnet-heimdall --node http://34.77.171.169:26657
```

### Sending transaction to become a validator

In order to become a validator you should send a ```create-validator``` transaction with the command below

```bash
bandd tx staking create-validator \
    --amount <your-amount-to-stake>loki \
    --commission-max-change-rate 0.01 \
    --commission-max-rate 0.2 \
    --commission-rate 0.1 \
    --from <your-wallet-name> \
    --min-self-delegation 1 \
    --moniker <your-moniker> \
    --pubkey $(bandd tendermint show-validator) \
    --chain-id odin-testnet-heimdall \
    --node http://34.77.171.169:26657
```

### Verifying the result

Perform the following command, and among the validators find the one with your moniker

```bash
bandd query staking validators --chain-id odin-testnet-heimdall --node http://34.77.171.169:26657
```

## Delegating tokens to someone

### Getting validator operator address

If the specified validator address is in your keyring:

```bash
bandd keys show <your-wallet> --bech val -a
```

Otherwise

```bash
bandd query staking validators --chain-id odin-testnet-heimdall --node http://34.77.171.169:26657
```

will return all the system validators, and you can get odinvaloper... address there

```bash
bandd tx staking delegate \
    <validator-operator-address> \
    <your-amount-to-delegate>loki \
    --from <your-wallet-name> \
    --chain-id odin-testnet-heimdall \
    --node http://34.77.171.169:26657
```