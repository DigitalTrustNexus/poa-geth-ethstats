#!/bin/bash

N=$1

sleep 5

for ((i=0;i<N;++i)); do
    id=`printf "%02d" $i`
    adr=$(jq '.address' clusters/3301/data/$id/keystore/UTC--*)
    adr=`echo $adr | sed 's/.\(.*\)/\1/' | sed 's/\(.*\)./\1/'`

    cat empty-genesis.json | jq --arg adr "$adr"  '.alloc[$adr].balance="0x200000000000000000000000000000000000000000000000000000000000000"' &> genesis2.json
    cat genesis2.json &> empty-genesis.json

    extraData=$extraData$adr
done

extraData='0x0000000000000000000000000000000000000000000000000000000000000000'$extraData'0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'


cat empty-genesis.json | jq --arg extraData "$extraData" '.extraData=$extraData' &> genesis2.json
cat genesis2.json &> empty-genesis.json

sleep 5