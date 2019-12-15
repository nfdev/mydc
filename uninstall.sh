#!/bin/bash

set -e

# Constants
declare MYDC=`echo ~/.mydc`

# Usage
usage_exit() {
  echo "USAGE: $0"
  exit 1
}

### Check Environment ###
docker --version >/dev/null 2>&1

if [ ${0} !=  "./uninstall.sh" ]; then
  echo "Run './uninstll.sh' in mydc directory'"
  exit 1
fi

while getopts hf OPT
do
  case $OPT in
    r)  FORCE="true"
        ;;
    h)  usage_exit
        ;;
  esac
done

### Delete containers ###
MYHOMEROOT=${MYDC}/home
ls ${MYHOMEROOT} | while read CNAME; do
  CID=`docker ps -a -q -f "name=^${CNAME}$"`
  MYHOME="${MYHOMEROOT}/${CNAME}"
  MYSHARE="${MYDC}/share"

  if [ "${CID}" != "" ]; then
    docker rm "${CID}"
  else
    echo "${CNAME} does not exist."
  fi
done

### Delete Docker Image ###
CID=`docker images -q mydc`

if [ "${CID}" != "" ]; then
  docker rmi "${CID}"
else
  echo "mydc image does not exist."
fi

### Deploy Scripts ###
if [ -d ${MYDC} -a "${FORCE}"="true" ]; then
  echo "rm ${MYDC}"
  rm -rf ${MYDC}
fi

### Setup for Shell ###
echo "Edit ~/.[zb]shsrc'"

### Exit ###
echo "Unintall done."
exit 0
