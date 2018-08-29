#!/bin/bash

N=$1

#eth-netstats
cd ../eth-netstats
WS_SECRET=hello npm start &

#GethCluster
cd ../GethCluster
bash netstatconf.sh $N cluster http://localhost:3000 hello > ../eth-net-intelligence-api/app.json

#eth-net-intelligence-api
cd ../eth-net-intelligence-api/
pm2 start app.json
pm2 monit