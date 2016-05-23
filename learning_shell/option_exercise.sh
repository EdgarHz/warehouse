#! /bin/sh -

## man getopt
# Options=`getopt "-o hnk: --long help,noclone,keyword::" $*`
#if [[ $? != 0 ]]; then
#    usage_and_exit
#fi
#set  -- $Options

usage(){
    echo "one getopt sample code"
    exit;
}
# : has one para :: may has one para
#  --long has long para
Options=`getopt "-o h -l help"  $*`
## echo as : -- --help

if [[ $? != 0 ]]; then
    echo "get Options failed"
    exit -1;
fi

# sort para
eval set  -- $Options
## should echo as : --help

while true; do
    echo $1;
    case $1 in
        -h| --help)
            usage;
            shift;
            ;;
        -k| --keyword)
            echo $1 $2
            shift 2;
            ;;
        -t| --tag)
            if [[ $2 -eq "" ]]; then
               echo "$1 has no para"
            fi
            shift 2
            ;;
        --)
            shift;
            break;
         ;;
    esac
done
