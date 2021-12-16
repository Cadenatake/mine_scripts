#!/bin/bash

instance_id='ocid1.instance.oc1.us-tokyo-1.hogehogehogehogefugafugafugafugafuga'

while [ "a" = "a" ]
do
	echo '-----------------------------------------------------'
	date
	# インスタンスの起動実行
	oci compute instance action --action start --instance-id ${instance_id}
	sleep 12
	
	# インスタンスが起動されているか確認し、起動されていればスクリプトを終了コード0で終了する。
	oci compute instance get --instance-id ${instance_id} | grep 'life' | grep 'RUNNING'  && exit 0
	sleep 12
	echo ''
done

exit 1