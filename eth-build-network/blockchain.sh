#!/bin/bash

pm2 delete ../eth-net-intelligence-api/app.json
if [ -d "clusters/" ]; then
    rm -rf clusters/
fi
if [ -f "password00.sec" ]; then
    rm password0*
fi
if [ -f "genesis.json" ]; then
    rm genesis.json
fi
rm ~/.ethash/*
echo '{
    "config": {
        "chainId": 1515,
        "homesteadBlock": 1,
        "eip150Block": 2,
        "eip150Hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
        "eip155Block": 3,
        "eip158Block": 3,
        "byzantiumBlock": 4,
        "clique": {
            "period": 1,
            "epoch": 30000
        }
    },
    "nonce": "0x0",
    "timestamp": "0x5a722c92",
    "extraData": "",
    "gasLimit": "0x59A5380",
    "difficulty": "0x1",
    "mixHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "coinbase": "0x0000000000000000000000000000000000000000",
    "alloc": {
    },
    "number": "0x0",
    "gasUsed": "0x0",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000"
 }' &> genesis.json
GETH=/usr/bin/geth bash ./create-nodes.sh ./clusters 3301 $1 127.0.0.1 -mine
