#!/usr/bin/env bash -

#fetch is under fossil control, if under, return 0
function fossilIsUnderControl(){
    isUnderfossilControl=`fossil status 2>&1 | grep "current directory is not within an open checkout"| wc -l`
    if [[ $isUnderfossilControl -eq 1 ]]; then
       echo -1
    else
       echo 0
    fi
}
#fetch url
function fossilUrl(){
	local fossilRemote=`fossil remote-url`
	echo $fossilRemote;
}
#fetch short name
function fossilShortName(){ 
local url=$1;
if [[ -z $url ]]; then
    url=`fossilUrl`;
fi
	url=${url#*://};
    url=${url//\//_};
    echo $url
}

#fetch branch name
function fossilBranch(){
    local fossilBranch=`fossil info | grep "tags:" | cut -d" " -f2`
    echo $fossilBranch;
}
#fetch has untracked file. if has, return 0
# function fossilHasUntrackedFile(){
#     local status=`fossil status | grep '^Untracked files'|wc -l`
#     if [[  $status == 1 ]]; then
#         echo 0
#     else
#         echo -1
#     fi
# }

#clone repo:$2 to dir:$1
function fossilCloneOrUpdate(){
    local fossilTargetDir=$1
	local fossilRemote=$2
    local pwdPath=`pwd`
	cd $fossilTargetDir
	local fossilDirName=$(fossilShortName $fossilRemote)
    if [ -d $fossilDirName ]; then
        cd $fossilDirName
        fossil pull
    else
        fossil clone $fossilRemote $fossilDirName
    fi
    local pwdPath=`pwd`
}

fossilShortName $1
#move fossil at $1 to $2/$3
# function fossilMove(){
#     local srcPath=$1
#     local dirPath=$2
# 	local fossilRemote=$3
# 	local fossilShortName=$(fossilShortName $fossilRemote)
# 	local targetPath="$2/$fossilShortName"
#     if [ -n $targetPath ] && [ ! -d $targetPath ]; then
#         echo "****$fossilShortName: mv from:`pwd` to:$targetPath"
#         mv  $srcPath $targetPath
#     fi
# }