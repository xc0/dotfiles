#!/bin/bash


while getopts ab:c: OPT
do
  case $OPT in
    "a" ) FLG_A="TRUE" ;;
     *  ) FLG_H="TRUE" ;;
  esac
done

if [ "$FLG_A" = "TRUE" ]; then
  echo '"-a"オプションが指定されました。'
fi
if [ "$FLG_H" = "TRUE" ]; then
  echo '"-h"オプションが指定されました。'
fi

exit 0

