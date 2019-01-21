#!/usr/bin/expect -f
set hxl [open hxltmp.txt w+] 
spawn ./ghpb --datadir ./node1/data  --networkid=66300 --port 8540 --nodetype bootnode --debug console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
close $hxl
expect ">" { send "exit\r" }
expect eof 
