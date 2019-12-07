#!/bin/bash

set -e

# Constants
declare MYDC=`echo ~/.mydc` MYTMPL="" MYBIN="" MYHOME=""

### Check Environment ###
docker --version >/dev/null 2>&1

if [ ${0} !=  "./install.sh" ]; then
  echo "Run './instll.sh' in mydc directory'"
  exit 1
fi


### Deploy Scripts ###
if [ -d ${MYDC} ]; then
  echo "~/.mydc already exits. Exit"
  exit 1
fi

MYTMPL="${MYDC}/template"
MYBIN="${MYDC}/bin"
MYHOME="${MYDC}/home"
mkdir ${MYDC}
mkdir ${MYTMPL}
mkdir ${MYBIN}
mkdir ${MYHOME}

ls ./template/dots | while read fname; do
  cp -r "./template/dots/${fname}" "${MYTMPL}/.${fname}"
done
ls ./template/undots | while read fname; do
  cp -r "./template/undots/${fname}" "${MYTMPL}/${fname}"
done

ls ./bin | while read fname; do
  cp -r "./bin/${fname}" "${MYBIN}/${fname}"
done

### Build mydc ###
docker build -t mydc:latest .
echo "Install done."

##### Think about chown #####
##

### Setup for Shell ###
echo "Run 'cat ./shrc >> ~/.zhsrc'"


### Exit ###
echo "Intall done."
exit 0
