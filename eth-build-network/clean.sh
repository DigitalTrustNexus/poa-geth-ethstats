#!/bin/bash

pm2 delete ../eth-net-intelligence-api/app.json
if [ -f "../eth-net-intelligence-api/app.json" ]; then
    rm ../eth-net-intelligence-api/app.json
fi
if [ -d "clusters/" ]; then
    rm -rf clusters/
fi
if [ -f "password00.sec" ]; then
    rm password0*
fi
if [ -f "genesis.json" ]; then
    rm genesis.json
fi
sudo kill `sudo lsof -t -i:3000`