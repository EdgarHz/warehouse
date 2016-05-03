#!/bin/sh

source "$ZyWarehouseDir/bin/zyevnDefine.sh"

if [ "$#" -eq 0 ]; then   # 脚本需要至少一个命令行参数.
  echo "Usage $0 -[options k,nc]"
  exit -1
fi

# 定义一个方法
foreachd(){
    local pathdir=$1
    local Files=`ls $pathdir`;
    for file in $Files;
    do
        if [ -d "$file" ]; then
            cd "$pathdir/$file"
            if [[ -d ".git" ]]; then
                local GitRemote=$(gitUrlOfThisDir)
                echo "----------at: $file find:$GitRemote"
                writeInfoToList $GitRemote ""
                copyAndUpdateGit  `pwd` $GitRemote
            elif [[ -d ".svn" ]]; then
                local svnRemote=$(svnUrlOfThisDir)
                 
                 local svnBranch=$(svnBranchOfThisDir)

                 echo "----------at: $file find:$svnRemote branch:$svnBranch"
                # writeInfoToList $GitRemote ""
                # copyAndUpdateGit  `pwd` $GitRemote
            elif [ "${file##*.}" != 'xcworkspace' ] && [ "${file##*.}" != 'xcodeproj' ] && [ "${file##*.}" != 'lproj' ]; then
                foreachd  `pwd`;
            fi
            cd "$pathdir"
        fi
    done
}

cd $1
foreachd `pwd`


