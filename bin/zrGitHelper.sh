#!/usr/bin/env bash -

#fetch is under git control, if under, return 0
function gitIsUnderControl(){
    isUnderGitControl=`git status 2>&1 | grep "fatal: Not a git repository"| wc -l`
    if [[ $isUnderGitControl -eq 1 ]]; then
       echo -1
    else
       echo 0
    fi
}
#fetch url
function gitUrl(){
	local GitRemote=`git remote -v| head -n1| cut -f2|cut -f1 -d"("`
	echo $GitRemote;
}
#fetch short name
function gitShortName(){
    local url=`gitUrl`;
	echo `basename $url | cut -d'.' -f1`
}

#fetch branch name
function gitBranch(){
    local gitBranch=`git branch | cut -d" " -f2`
    echo $gitBranch;
}
#fetch has untracked file. if has, return 0
function gitHasUntrackedFile(){
    local status=`git status | grep '^Untracked files'|wc -l`
    if [[  $status == 1 ]]; then
        echo 0
    else
        echo -1
    fi
}

#clone repo:$2 to dir:$1
function gitCloneOrUpdate(){
    local gitTargetDir=$1
	local gitRemote=$2
    local pwdPath=`pwd`
	cd $gitTargetDir
	local GitDirName=`basename $gitRemote | cut -d'.' -f1`
    if [ -n $gitRemote ]; then
        git clone $GitRemote $GitDirName
    else
        cd $GitDirName
        git pull
    fi
    local pwdPath=`pwd`
}

#move git at $1 to $2/$3
function gitMove(){
    local srcPath=$1
    local dirPath=$2
	local gitRemote=$3
	local gitShortName=`basename $gitRemote | cut -d'.' -f1`
	local targetPath="$2/$gitShortName"
    if [ -n $targetPath ] && [ ! -d $targetPath ]; then
        echo "****$gitShortName: mv from:`pwd` to:$targetPath"
        mv  $srcPath $targetPath
    fi
}