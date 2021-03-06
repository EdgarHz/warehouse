#!/bin/sh


WarehouseBaseDir=`dirname $0`/..
RepoRootDirName="repos"
RegisterTxtFileName="RepoList.txt"


RepoRootDir="$WarehouseBaseDir/$RepoRootDirName"
. "$WarehouseBaseDir/bin/zrhelper/zrCommon.sh"
. "$WarehouseBaseDir/bin/zrhelper/zrGitHelper.sh"
. "$WarehouseBaseDir/bin/zrhelper/zrSvnHelper.sh"
. "$WarehouseBaseDir/bin/zrhelper/zrFossilHelper.sh"
 
#创建相关目录
function checkDir(){
	local oldpath=`pwd`
	cd $WarehouseBaseDir
	if [ ! -d $RepoRootDirName ]; then
	  mkdir $RepoRootDirName
	  echo "$RepoRootDirName/" | cat >> .gitignore
	fi

	if [ ! -f $RegisterTxtFileName ]; then
	  touch $RegisterTxtFileName
	fi
	cd $oldpath;
}

#写到列表文件
function writeInfoToList(){
	local repoType=$1;
	local shortName=$2;
	local Url=$3;
	local Keyword=$4;
	local LineContent="$repoType $shortName $Url $Keyword"
	echo $LineContent | cat >> $WarehouseBaseDir/$RegisterTxtFileName
	uniqRepoInfoList
}

function uniqRepoInfoList(){
	sort $WarehouseBaseDir/$RegisterTxtFileName | uniq | cat > $WarehouseBaseDir/temp.txt
	mv $WarehouseBaseDir/temp.txt $WarehouseBaseDir/$RegisterTxtFileName
}

checkDir