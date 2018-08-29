#!/bin/bash

N=$1

#eth-netstats
cd ../eth-netstats
WS_SECRET=hello npm start &

#eth-build-network
cd ../eth-build-network
bash netstatconf.sh $N cluster http://localhost:3000 hello > ../eth-net-intelligence-api/app.json

#eth-net-intelligence-api
cd ../eth-net-intelligence-api/
pm2 start app.json
pm2 monit