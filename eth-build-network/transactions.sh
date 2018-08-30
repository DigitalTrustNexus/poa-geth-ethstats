#!/bin/bash

time=$1
shift
From=$1
shift
To=$1
shift
Password=$1
shift

while : ; do
    sleep $time
    curl --data "{\"jsonrpc\":\"2.0\",\"method\":\"personal_sendTransaction\",\"params\":[{\"from\":\"$From\",\"to\":\"$To\",\"value\":\"0xde0b6b3a7640000\"}, \"$Password\"],\"id\":0}" -H "Content-Type: application/json" -X POST localhost:8500
done