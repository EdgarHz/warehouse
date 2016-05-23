#! /bin/sh
CurrentShellDir=`dirname $0`
echo $CurrentShellDir;

DemoText=$CurrentShellDir/awkdemo.txt
#cp $CurrentShellDir/awkdemo.txt $CurrentShellDir/awkdemo.backup.txt
#
#echo "try: awk '{print \$1 \$3}'"
#last -1
#echo "\n---contrast"
#last -1 | awk '{print $1 "\t" $2}'
#read
#
#echo "try: NF number of field '{print NF}'"
#last -1 | awk '{print NF}'
#
#echo "try: NR number of rows '{print NR}'"
#last -1 | awk '{print NR}'
#
#echo "try: FS field seperator '{print (  FS  )}'"
#last -1 | awk '{print "("  FS  ")"}'
#
#echo "注意喔，在 awk 内的 NR, NF 等变量要用大写，且不需要有钱字号 $ 啦！"
#read


cat /etc/passwd | \
awk '{FS=":"}  $3 < 10 {print $1 "\t" $3 }'

echo "\ntry: NR==1{} N>=2{}"
cat $CurrentShellDir/pay.txt
echo "\n---contrast"
cat $CurrentShellDir/pay.txt | \
awk 'NR==1{printf "%10s %10s %10s %10s %10s\n",$1,$2,$3,$4,"Total" }
NR>=2{total = $2 + $3 + $4
printf "%10s %10d %10d %10d %10.2f\n", $1, $2, $3, $4, total}'
echo "awk 的命令间隔：所有 awk 的动作，亦即在 {} 内的动作，如果有需要多个命令辅助时，可利用分号『;』间隔， 或者直接以 [Enter] 按键来隔开每个命令"
echo "与 bash shell 的变量不同，在 awk 当中，变量可以直接使用，不需加上 $ 符号。"
echo "如果是『等於』的情况，则务必使用两个等号『==』"
echo "在 printf 的格式配置当中，务必加上 \ n ，才能进行分行\n"

#cat $CurrentShellDir/pay.txt | \
#awk 'NR==1{
#printf "%10s %10s %10s %10s %10s\n",$1,$2,$3,$4,"Total" }
#NR>=2{total = $2 + $3 + $4
#printf "%10s %10d %10d %10d %10.2f\n", $1, $2, $3, $4, total}'
#echo "不同的分行,不同的输出"
cat pay.txt | \
awk '{if(NR==1) printf "%10s %10s %10s %10s %10s\n",$1,$2,$3,$4,"Total"}
NR>=2{total = $2 + $3 + $4
printf "%10s %10d %10d %10d %10.2f\n", $1, $2, $3, $4, total}'