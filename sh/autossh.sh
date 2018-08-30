#!/bin/bash

# 本脚本用于ubuntu下为集群机器配置免密登录

SERVERS="222.128.104.75:50006 222.128.104.75:50000 222.128.104.75:50001 222.128.104.75:50002 222.128.104.75:50002 222.128.104.75:50003 222.128.104.75:50004 222.128.104.75:50005"
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

# copy id to local.
ssh_copy_id_to_all

