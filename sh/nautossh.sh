#!/bin/bash

# 本脚本用于ubuntu下为集群机器配置免密登录

SERVERS="221.194.153.107:22 221.194.153.108:22 221.194.153.109:22 222.222.12.3:22 222.222.12.4:22 222.222.12.13:22 111.63.48.11:22 111.63.48.12:22 111.63.48.13:22 47.75.213.166:22"
USER=hpb
PASSWORD=hpb123456

Expect=`ls /usr/bin | grep expect`
#if [ ! -n "$Expect" ];
#then
#    echo "Not find expect, install it"
#    # install expect.
#    sudo apt-get install tcl tk expect -y
#fi
#
## 1. local keygen
#ssh-keygen

auto_ssh_copy_id() {
    expect -c "set timeout -1;
        spawn ssh-copy-id -p $2 $3@$1;
        expect {
            *(yes/no)* {send -- yes\r;exp_continue;}
            *assword:* {send -- $4\r;exp_continue;}
            eof        {exit 0;}
        }";
}

ssh_copy_id_to_all() {
    for SERVER in $SERVERS
    do
        IP=`echo $SERVER | cut -f1 -d:`
        PORT=`echo $SERVER | cut -f2 -d:`
        auto_ssh_copy_id $IP $PORT $USER $PASSWORD
    done
}

copy_file_to_all() {
    for SERVER in $SERVERS
    do
        IP=`echo $SERVER | cut -f1 -d:`
        PORT=`echo $SERVER | cut -f2 -d:`
        scp -P $PORT $1 $USER@$IP:~/
    done
}
# copy id to local.
#ssh_copy_id_to_all
#copy_file_to_all ntp-4.2.8p12.tar.gz
copy_file_to_all install.sh

