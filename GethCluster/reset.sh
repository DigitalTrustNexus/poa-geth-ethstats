#!/bin/bash

rm -rf clusters/
rm -rf password0*
rm -rf genesis*
GETH=/usr/bin/geth bash ./gethcluster.sh ./clusters 3301 4 127.0.0.1 -mine
