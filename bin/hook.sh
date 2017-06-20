#!/bin/sh

REPOROOT=`dirname $0`
foreachd() {
	local FILES=`ls`;
	for file in $FILES; do
		if [[ -d $file ]]; then
			if  [[ $file = "Pods" ]] \
				|| [[ $file = ".hg" ]] \
				|| [[ $file = ".svn" ]] \
				|| [[ $file = ".git" ]] \
				|| [[ ${file##*.} = 'xcassets' ]]; then
				#statements
				continue;
			else
				cd ./$file 
				foreachd
				cd ..
			fi

		elif [[ -f $file ]] ; then
			if [[ ${file##*.} = 'm' ]] \
				|| [[ ${file##*.} = 'mm' ]] \
				|| [[ ${file##*.} = 'h' ]] ; then
				echo $file
			fi
		fi
	done
}

foreachd