#!/bin/sh
WarehouseBinDir=`dirname $0`;
source "$WarehouseBinDir/zWarehouseCommon.sh"

Keyword=''
while getopts "k:n" arg;
do
    case $arg in
        k)
            Keyword="$OPTARG"
            echo "Description: $Keyword"
            ;;
        n)
            WontCloneIt=true;
            echo "will not clone it to $BaseDir/$Repo_Root"
            ;;
        ?)
            echo "-k add keywords for this git repo"
            echo "-nc only add it to list, no clone it to repos directory"
            echo "no -- options"
            exit;
            ;;
    esac
done

shift $(($OPTIND -1))

if [ "$#" -eq 0 ]; then   # 脚本需要至少一个命令行参数.
  echo "Usage $0 -[options k,nc]"
  exit -1
fi

GitRemote=$1

writeInfoToList $GitRemote $Keyword

if [ ! $WontCloneIt ]; then
    cloneOrUpdateGit $GitRemote
fi






