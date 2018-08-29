#!/bin/bash

N=$1

for ((i=0;i<N;++i)); do
    id=`printf "%02d" $i`
    address=$(jq '.address' clusters/3301/data/$id/keystore/UTC--*)
    address=`echo $address | sed 's/.\(.*\)/\1/' | sed 's/\(.*\)./\1/'`

    cat genesis.json | jq --arg address "$address"  '.alloc[$address].balance="0x200000000000000000000000000000000000000000000000000000000000000"' &> genesis2.json
    cat genesis2.json &> genesis.json

    extraData=$extraData$address
done

extraData='0x0000000000000000000000000000000000000000000000000000000000000000'$extraData'0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'


cat genesis.json | jq --arg extraData "$extraData" '.extraData=$extraData' &> genesis2.json
cat genesis2.json &> genesis.json
rm genesis2.json