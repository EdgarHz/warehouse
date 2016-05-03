BaseDir=$ZyWarehouseDir
Repo_Root="repos"
Register_Txt="RepoList.txt"

#创建相关目录
function checkDir(){
	local pwdPath=`pwd`
	cd $BaseDir
	if [ ! -d $Repo_Root ]; then
	  mkdir $Repo_Root
	  echo "$Repo_Root/" | cat >> .gitignore
	fi

	if [ ! -f $Register_Txt ]; then
	  touch $Register_Txt
	fi
	cd $pwdPath

}

#通过截断得到当前文件夹中的git的url地址
function gitUrlOfThisDir(){
	local GitRemote=`git remote -v| head -n1| cut -f2|cut -f1 -d"("`
	echo $GitRemote;
}
#通过截断得到当前文件夹中的svn的url地址
function svnUrlOfThisDir(){
	local svnRemote=`svn info | grep "^Repository Root: "`
	svnRemote=${svnRemote:16}
	echo $svnRemote
}
#通过截断得到当前文件夹中的svn的分支
function svnBranchOfThisDir(){
	local svnRemote=`svn info | grep "^URL: "`
	echo "branch s:"$svnRemote
	svnRemote="${svnRemote:5}";
	echo $svnRemote
	svnRemote=`basename svnRemote`
	echo "branch e:"$svnRemote
	echo $svnRemote;
}

#写到列表文件
function writeInfoToList(){
	local Url=$1;
	local Keyword=$2;
	local LineContent="$Url \tkeywords: $Keyword"
	echo $LineContent | cat >> $BaseDir/$Register_Txt
	sort $BaseDir/$Register_Txt | uniq | cat > $BaseDir/temp.txt
	mv $BaseDir/temp.txt $BaseDir/$Register_Txt
}


function shortNameByGit(){
	echo `basename $1 | cut -d'.' -f1`
}
function shortNameBySvn(){
	echo ""

}


function cloneOrUpdateGit(){
	local GitRemote=$1
	local pwdPath=`pwd`
	cd $Repo_Root
	local GitDirName=`basename $GitRemote | cut -d'.' -f1`
    if [ -n $GitRemote ]; then
        echo $GitRemote "--->" $GitDirName
        git clone $GitRemote $GitDirName
    else
        cd $GitDirName
        git pull
    fi
    cd $pwdPath
}
function cloneOrUpdateSvn(){
	local svnRemote=$1
	local svnBranch=$2
	local pwdPath=`pwd`
	cd $Repo_Root
	local svnDirname=`basename $svnRemote | cut -d'.' -f1`
    if [ -n $svnRemote ]; then
        echo $svnRemote "--->" $svnDirname
       # git clone $svnRemote $svnDirname
    else
        cd $svnDirname
        git pull
    fi
    cd $pwdPath
}


function copyAndUpdateGit(){
	cd $1
	local GitRemote=$2
	local gitshortName=`basename $GitRemote | cut -d'.' -f1`
	local TargetPath="$BaseDir/$Repo_Root/$gitshortName"
    if [ -n $TargetPath ] && [ ! -d $TargetPath ]; then
        echo "****" $GitRemote "--->" $gitshortName
        echo "****mv `pwd` $TargetPath"
        mv  `pwd` $TargetPath
        cd "$TargetPath"
        git pull
    # else
    #     cd "$TargetPath"
    #     git pull
    fi
}

checkDir