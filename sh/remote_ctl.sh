#!/bin/bash

light_list=(
'127.0.0.1 luxq Avl1108'
'127.0.0.1 luxq Avl1108'
'127.0.0.1 luxq Avl1108'
)
# remote_fun 192.168.23.176 luxq Avl1108 cmd
FUNC_RESULT=
remote_run(){
    rip=$1
    ruser=$2
    rpass=$3
    rcmd=$4
    FUNC_RESULT=`sshpass -p $rpass ssh $ruser@$rip $rcmd`
}

#remote_run 127.0.0.1 luxq Avl1108 "ls /mnt/code/"
#echo $FUNC_RESULT

#for i in "${light_list[@]}";
#do
#    info=$i
#    rip=${info[0]}
#    ruser=${info[1]}
#    rpass=${info[2]}
#    echo $rip $ruser $rpass
#    remote_run $rip $ruser $rpass "ls "
#    echo $FUNC_RESULT
#done

for i in "${light_list[@]}";
do
    info=$i
    rip=${info[0]}
    ruser=${info[1]}
    rpass=${info[2]}
    remote_run $rip $ruser $rpass 'mkdir ~/ghpb_sh'
    sshpass -p $rpass scp ./* $ruser@$rip:~/ghpb_sh/
    #echo $FUNC_RESULT
done
