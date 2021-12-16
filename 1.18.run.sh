#!/bin/bash
JAVA16PARH='/usr/lib/jvm/java-17-openjdk-17.0.1.0.12-2.el8_5.aarch64/bin/java'
# SERVERJARPATH='./minecraft_server1.18.jar'
SERVERJARPATH='./spigot-1.18.jar'
LOGPATH="$HOME/minecraft_server_running.log"

LOGDATASTAMP=`date '+%Y-%m-%d-%H%M%S'`
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}

echo ${LOGDATASTAMP} > ${LOGPATH}
/usr/lib/jvm/java-17-openjdk-17.0.1.0.12-2.el8_5.aarch64/bin/java -Xmx10g -Xms10g -jar ${SERVERJARPATH} -nogui -eraseCache | tee -a ${LOGPATH}
