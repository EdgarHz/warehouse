#!/usr/bin/env bash -

#fetch is under svn control
function svnIsUnderControl(){
    isUnderSvnControl=`svn info 2>&1 | grep "is not a working copy"| wc -l`
    if [[ $isUnderSvnControl -eq 1 ]]; then
       echo -1
    else
       echo 0
    fi

}
#fetch url
function svnUrl(){
	local svnRemote=`svn info | grep "^Repository Root: "`
	svnRemote=${svnRemote:16}
	echo $svnRemote
}
function svnShortName(){
    local svnName=$1;
    if [[ -z $svnName ]]; then
       svnName=`svnUrl`
    fi
    svnName=${svnName##*/};
    echo $svnName;
}

#fetch branch name
function svnBranch(){
	local svnRemote=`svn info | grep "^URL: "`
	svnRemote="${svnRemote:5}";
	svnRemote=`basename $svnRemote`
	echo $svnRemote;
}

#fetch has untracked file: as ? **.file, if has, return 0
function svnHasUntrackedFile(){
    local status=`svn status | grep '^\?'`
    if [[ ! -z $status ]]; then
        echo 0
    else
        echo -1
    fi
}

#clone repo:$2 to dir:$1
function svnCloneOrUpdate(){
    local svnTargetDir=$1
	local svnRemote=$2
	local pwdPath=`pwd`
	cd $svnTargetDir;
	local svnDirname=`basename $svnRemote | cut -d'.' -f1`
    if [ -d $svnDirname ]; then
        cd $svnDirname
        svn update
    else
        svn clone $svnRemote $svnDirname
    fi
    cd $pwdPath
}
#move git at $1 to $2/$3
# function svnMove(){
#     local srcPath=$1
#     local dirPath=$2
#     local svnShortName=$3
#     local targetPath="$dirPath/$gitShortName"
#     if [ -n $targetPath ] && [ ! -d $targetPath ]; then
#         echo "****$svnShortName: mv from:$srcPath to:$targetPath"
#         mv  $srcPath $targetPath
#     fi
# }

function testSvnFunc(){
    if [[ svnIsUnderControl -eq 0 ]]; then
        cd $1
        svnUrl
        svnShortName
        svnBranch
        svnHasUntrackedFile;
        svnCloneOrUpdate $1 "url"
    fi
}