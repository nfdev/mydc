#!/bin/bash

set -eu

# Constants
declare FORCE=""
declare MYDC=`echo ~/.mydc` MYTMPL="" MYBIN="" MYHOME="" MYSHARE="" MYDF=""

# Usage
usage_exit() {
  echo "USAGE: $0"
  exit 1
}

### Check Environment ###
docker --version >/dev/null

if [ ${0} !=  "./install.sh" ]; then
  echo "Run './instll.sh' in mydc directory'"
  exit 1
fi

while getopts hf OPT
do
  case $OPT in
    f)  FORCE="true"
        ;;
    h)  usage_exit
        ;;
  esac
done


### Deploy Scripts ###
MYTMPL="${MYDC}/template"
MYBIN="${MYDC}/bin"
MYHOME="${MYDC}/home"
MYSHARE="${MYDC}/share"
MYDF="${MYDC}/dc"

if [ "${FORCE}" == "true" ];then
  # Keep my home and myshare, delete all others.
  find ${MYDC} -maxdepth 1 -type d | grep -v "{$MYHOME}" | grep -v "{$MYSHARE}" \
  | while read dname; do
    if [ -d ${dname} ]; then
      rm -rf ${dname}
    fi
  done
else
  if [ -d ${MYDC} ]; then
    echo "~/.mydc already exits. Exit"
    exit 1
  fi
fi

while read dname; do
  if [ ! -d ${dname} ]; then
    mkdir ${dname}
  fi
done <<EOF
${MYDC}
${MYTMPL}
${MYBIN}
${MYHOME}
${MYSHARE}
${MYDF}
EOF

ls ./template/dots | while read fname; do
  cp -r "./template/dots/${fname}" "${MYTMPL}/.${fname}"
done

ls ./template/undots | while read fname; do
  cp -r "./template/undots/${fname}" "${MYTMPL}/${fname}"
done

ls ./bin | while read fname; do
  cp -r "./bin/${fname}" "${MYBIN}/${fname}"
done

ls ./dc | while read fname; do
  cp -r "./dc/${fname}" "${MYDF}/${fname}"
done

### Build mydc ###
cd ./dc
docker build -t mydc:latest .
echo "Install done."
cd ../

##### Think about chown #####
##

### Setup for Shell ###
echo "Run 'cat ./[zb]shrc >> ~/.[zb]shrc'"
echo "Put ./config.json to ~/.docker"

### Setup for Shell ###
if [ ! -d ~/.docker ]; then
  mkdir ~/.docker
fi
echo '{ "detachKeys": "ctl-\\" }' >> ~/.docker/config.json

### Exit ###
echo "Intall done."
exit 0
