#!/usr/bin/env bash

rm -rf ~/.band

bandd init oracle-node --chain-id odin-testnet-vidar

cp /genesis.json ~/.band/config/genesis.json
cp /priv_validator_key.json ~/.band/config/priv_validator_key.json

sed -i 's/enable = false/enable = true/' ~/.band/config/app.toml

# uncomment to disable cors
#sed -i 's/enabled-unsafe-cors = false/enabled-unsafe-cors = true/' ~/.band/config/app.toml
#sed -i 's/cors_allowed_origins = \[\]/cors_allowed_origins = ["*"]/' ~/.band/config/config.toml