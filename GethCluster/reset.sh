#!/bin/bash

rm -rf clusters/
rm password0*
rm genesis2.json
GETH=/usr/bin/geth bash ./gethcluster.sh ./clusters 3301 $1 127.0.0.1 -mine
