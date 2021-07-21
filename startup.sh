#!/bin/bash

VENDOR=${VENDOR}

if [ -z $VENDOR ];then
  # shellcheck disable=SC1073
  echo "NO VENDOR Provided"
  echo "possible Vendor is :"
  echo "Inspur,DELL,H3C,Supermicro,Suma"
  exit 1
fi
dir=/scripts
if [[ $VENDOR == DEL* ]];then
  dir=$dir/dell
elif [[ $VENDOR == Inspur* ]];then
  dir=$dir/inspur
elif [[ $VENDOR == *H3C* ]];then
  dir=$dir/h3c
elif [[ $VENDOR == Supermicro* ]];then
  dir=$dir/supermicro
elif [[ $VENDOR == Suma* ]];then
  dir=$dir/sugo
else
  echo "Not supported Vendor: $VENDOR"
  exit 1
fi

/bin/bash $dir/startup.sh