#!/bin/bash

BACKUPDIRPATH='/minecraft_server/world_data/1.17.1/'

while [ "a" = "a" ]
do
	#バックアップディレクトリの使用容量を取得しGiB表示でなければバッチを終了する
	skicka du | grep "${BACKUPDIRPATH}" | grep -v 'GiB' && echo "bunki 3" && exit 0
	
	#バックアップディレクトリの使用容量を取得する
	USEDSPACE=`skicka du | grep "${BACKUPDIRPATH}" | awk '{print $1}'`
	
	#USEDSPACEが2より大きければresultに1を返す
	result=`echo "${USEDSPACE} > 2" | bc`
	
	if [ $result -eq 1 ]; then
		RM_BACKUPFILE=`skicka ls ${BACKUPDIRPATH} | head -n 1`
		RM_BACKUPFILEPATH="${BACKUPDIRPATH}${RM_BACKUPFILE}"
		skicka rm ${RM_BACKUPFILEPATH}
	else
		echo "bunki 3"
		exit 0
	fi
done

exit 1