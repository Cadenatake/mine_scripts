#!/bin/bash

#第一引数 Minecraftバージョン指定
MINECRAFT_VERSION=$1

SERVERJAR="spigot-${MINECRAFT_VERSION}.jar"
LOGPATH="$HOME/minecraft_server_running.log"

LOGDATASTAMP=`date '+%Y-%m-%d-%H%M%S'`
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}

echo ${LOGDATASTAMP} > ${LOGPATH}
java -Xmx1g -Xms1g -jar ${SERVERJAR} -nogui -eraseCache | tee -a ${LOGPATH}

exit 0