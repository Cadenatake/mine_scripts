#!/bin/bash

case $1 in
1.18.1)
    REPOSITORYNAME='Minecraft1.18.1'
    ;;
1.19)
    REPOSITORYNAME='Minecraft1.19'
    ;;
esac

WORLDDATAPATH="${HOME}/${REPOSITORYNAME}"
GITPATH="${HOME}/git"
GITDATAPATH="${GITPATH}/${REPOSITORYNAME}"

exit 0