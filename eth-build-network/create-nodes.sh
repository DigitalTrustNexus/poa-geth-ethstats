#!/bin/bash

root=$1
shift
network_id=$1
dir=$root/$network_id
mkdir -p $dir/data
mkdir -p $dir/log
shift
N=$1
shift
ip_addr=$1
shift

genesis=genesis.json

GETH=`which geth`

for ((i=0;i<N;++i)); do
  id=`printf "%02d" $i`
  mkdir -p $dir/data/$id
  echo "launching node $(expr $i + 1)/$N ---> tail-f $dir/log/$id.log"
  echo $id > password$id.sec
  echo ./create-accounts.sh $dir $id password$id.sec $*
  ./create-accounts.sh $dir $id password$id.sec $*
done

./add-sealers-to-genesis.sh $N

if [ ! -f $dir/nodes  ]; then

  echo "[" >> $dir/nodes
  for ((i=0;i<N;++i)); do
    id=`printf "%02d" $i`
    if [ ! $ip_addr="" ]; then
      ip_addr="[::]"
    fi

	if [ ! -d $dir/data/$id/geth ]; then
		echo "Initializing Genesis block"
		geth --datadir $dir/data/$id init $genesis &> /dev/null
		echo "Genesis initialized"
	fi

    echo "getting enode for instance $id ($i/$N)"
    eth="$GETH --datadir $dir/data/$id --port 303$id --networkid $network_id"
    cmd="$eth js <(echo 'console.log(admin.nodeInfo.enode); exit();') "
    echo $cmd
    bash -c "$cmd" 2>/dev/null |grep enode | perl -pe "s/\[\:\:\]/$ip_addr/g" | perl -pe "s/^/\"/; s/\s*$/\"/;" | tee >> $dir/nodes
    if ((i<N-1)); then
      echo "," >> $dir/nodes
    fi
  done
  echo "]" >> $dir/nodes
fi

for ((i=0;i<N;++i)); do
  id=`printf "%02d" $i`

  datadir=$dir/data/$id
  port=303$id
  rpcport=85$id
  password=password$id.sec
  bootnodes=$(cat $PWD/clusters/3301/nodes | tr [ '%' | tr ] '%' | tr '\n' '%' | tr '"' '%' | sed 's/\%//g')
  echo $bootnodes
  echo "Extra Arguments for "$id $*
  $GETH \
    --syncmode full \
    --bootnodes $bootnodes \
    --identity "$dd" \
    --datadir $datadir \
    --rpcapi admin,net,eth,web3,miner,personal \
    --rpc \
    --rpccorsdomain='*' \
    --rpcport $rpcport \
    --port $port \
    --unlock 0 \
    --password $password $* &
done
