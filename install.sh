#!/bin/bash

### Check Environment ###
docker --version >/dev/null 2>&1
if [ ${?} != 0 ]; then
  echo "Docker not exist. Exit."
  exit 1
fi

if [ ${0} !=  "./install.sh" ]; then
  echo "Run './instll.sh' in mydc directory'"
fi


### Deploy Scripts ###
mkdir ~/.mydc

ls ./template/dots | while read fname; do
  cp -r "./template/dots/${fname}" "./template/.${fname}"
done
ls ./template/undots | while read fname; do
  cp -r "./template/undots/${fname}" "./template/${fname}"
done

if [ ${?} != 0 ]; then
  echo "Template copy error. Exit."
  exit 1
fi

cp -r ./scripts ~/.mydc
if [ ${?} != 0 ]; then
  echo "Script copy error. Exit."
  exit 1
fi


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
