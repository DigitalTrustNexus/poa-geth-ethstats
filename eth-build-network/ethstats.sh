#!/bin/bash

N=$1

#eth-netstats
cd ../eth-netstats
WS_SECRET=hello npm start &

sleep $N #eth-build-network
cd ../eth-build-network
bash netstatconf.sh $N node http://localhost:3000 hello > ../eth-net-intelligence-api/app.json

sleep $N #eth-net-intelligence-api
cd ../eth-net-intelligence-api/
pm2 start app.json

#Shutdown
# pm2 stop app.json
# rm app.json