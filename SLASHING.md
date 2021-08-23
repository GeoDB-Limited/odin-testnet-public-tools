### Getting validator operator address
If the specified validator address is in your keyring:
```bash
bandd keys show <your-wallet> --bech val -a
```

Otherwise
```bash
bandd query staking validators --chain-id odin-testnet-baldur --node https://node.testnet.odinprotocol.io/nidavellir
```
will return all the system validators, and you can get odinvaloper... address there

```bash
bandd tx slashing unjail \
    --from=<operator-key-name> \
    --chain-id odin-testnet-baldur \
    --node https://node.testnet.odinprotocol.io/nidavellir
```