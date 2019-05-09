#!/bin/sh

if [[ -d "/init-scripts.d" ]]; then
  echo "Executing pre-run scripts"
  for file in /init-scripts.d/*;do
    echo "executing file $file"
    ${file}
  done
fi


if [[ -z "$DEBUG" ]];then
  ipsec start --nofork --debug
else
  ipsec start --nofork
fi

