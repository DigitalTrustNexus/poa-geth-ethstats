#!/bin/bash

root=$1
shift
dd=$1
shift
password=$1
shift

GETH=`which geth`
datetag=`date "+%c%y%m%d-%H%M%S"|cut -d ' ' -f 5`
datadir=$root/data/$dd
log=$root/log/$dd.$datetag.log
linklog=$root/log/$dd.current.log
stablelog=$root/log/$dd.log

mkdir -p $root/data
mkdir -p $root/log
ln -sf "$log" "$linklog"
if [ ! -d "$root/keystore/$dd" ]; then
  echo create an account with password $dd [DO NOT EVER USE THIS ON LIVE]
  mkdir -p $root/keystore/$dd
  $GETH --datadir $datadir --password $password account new &> /dev/null
  echo "Account created"
  cp -R "$datadir/keystore" $root/keystore/$dd
fi