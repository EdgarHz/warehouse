#!/usr/bin/env bash

source "$ZyWarehouseDir/bin/zyevnDefine.sh"

if [ "$#" -eq 0 ]; then   # 脚本需要至少一个命令行参数.
  echo "Usage $1 must be one keywords or git remote url"
  exit -1
fi

cd $BaseDir
grep $1 $Register_Txt