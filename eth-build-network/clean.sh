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