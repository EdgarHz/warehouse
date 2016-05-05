# Warehouse
The warehouse for git repo which I focused. 

## goal
	list of git repo
	classify git repo
	can clone git repo 
	can auto update git repo 

	
##analyze
	1. when clone one git repo to local, should register it to db
	2. auto backup this change to server, and ignore git repo files.
	3. can download one category of git repo form list.
	4. backup note to server 

##Need:
	1. a script to clone, such as:
		zgit clone ****/abc.git -t * -d:xxx
		--> abc  ***/abc.git  tag: *  description:XXX

	2. a script to list category, such as:
		zgitsearch  -t:  ab
		--> s1 ***  tag: ab 

        zgitsearch  -k:  ab
        --> s1  *** tag:ab 
        --> s2  *** tag:cc description:ab, cc 

	3. a script to download, such as:
		zgitclone -l  aa, bb, cc
		zgitsearch  -k:  ab | zgitclone -ignore ***
	
	4. a script to backup note, such as:
		zgitbackup 

