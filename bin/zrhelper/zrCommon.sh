#!/usr/bin/env bash -
#move git at $1 to $2/$3
function mvDirIfExistDoNothing(){
    local srcPath=$1
    local dirPath=$2
	local dirName=$3
	local targetPath="$dirPath/$dirName"
    if [ -n $targetPath ] && [ ! -d $targetPath ]; then
        echo "mv from:$srcPath to:$targetPath"
        mv  $srcPath $targetPath
    fi
}

function mvDirIfExistDoNothing(){
    local srcPath=$1
    local dirPath=$2
	local dirName=$3
	local dirBackup=$4
	local targetPath="$dirPath/$dirName"
    if [ -n $targetPath ] && [ ! -d $targetPath ]; then
        echo "mv from:$srcPath to:$targetPath"
        mv  $srcPath $targetPath
    else 
    	mv $srcPath $dirBackup
    fi
}