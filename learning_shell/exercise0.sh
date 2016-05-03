#! /bin/sh
# echo "hello"

# {}匿名函数, 
echo "testing {}, anonymous funciton"
{
	local t1a; #line 6: local: can only be used in a function
	t1a=3;
	t1b=3;
	}
echo "var in anonymous function, can be used in outer function:" $t1b;


echo "testing (), run in sub shell"
(
	t2aInSubShell=3;
	echo "echo in sub shell: var=", $t2aInSubShell;
	)
echo "echo in main shell: var="$t2InSubShell;


let "t3a=3"
echo "let \"a=3\", equal: a=" $t3a;

t4a=`pwd`
t4b=$(pwd) #命令替换的一种
echo "var=\`cmd\`, equal: var=\$(pwd)"

function t5f() {
	local t5a=30;
	echo "$*, all para:" $*;
	echo "$@, all para:" $@;
	echo "$1, para first:" $1;
	echo "$#, para count:" $#;
	shift 2
	echo "shift 2, para first:" $1;
}
t5f 1 2 3 4


