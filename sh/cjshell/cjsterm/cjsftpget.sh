#!/usr/bin/expect -f
set ar1 [lindex $argv 0]
set ar2 [lindex $argv 1]
set ar3 [lindex $argv 2]
set ar4 [lindex $argv 3]
set ar5 [lindex $argv 4]
set ar6 [lindex $argv 5]
set ar7 [lindex $argv 6]
set ar8 [lindex $argv 7]
set ar9 [lindex $argv 8]
set ar10 [lindex $argv 9]
set ar11 [lindex $argv 10]
set ar12 [lindex $argv 11]
set ar13 [lindex $argv 12]
set ar14 [lindex $argv 13]
set ar15 [lindex $argv 14]
set ar16 [lindex $argv 15]
set ar17 [lindex $argv 16]
set ar18 [lindex $argv 17]
set ar19 [lindex $argv 18]
set ar20 [lindex $argv 19]
set ar21 [lindex $argv 20]
set ar22 [lindex $argv 21]
set ar23 [lindex $argv 22]
set ar24 [lindex $argv 23]
set ar25 [lindex $argv 24]
set ar26 [lindex $argv 25]
set ar27 [lindex $argv 26]
set ar28 [lindex $argv 27]
set ar29 [lindex $argv 28]
set ar30 [lindex $argv 29]
set ar31 [lindex $argv 30]

spawn  sftp $ar2@$ar1
expect { 
   "Are you sure you want to continue connecting (yes/no)?" {  send "yes\r";exp_continue }
   "password:" { send "$ar3\r"}
}
expect "sftp>" { send "cd $ar4\r"}
expect "sftp>" { send "mget $ar5\r"}
expect "sftp>" { send "mget $ar6\r"}
expect "sftp>" { send "mget $ar7\r"}
expect "sftp>" { send "mget $ar8\r"}
expect "sftp>" { send "mget $ar9\r"}
expect "sftp>" { send "mget $ar10\r"}
expect "sftp>" { send "mget $ar11\r"}
expect "sftp>" { send "mget $ar12\r"}
expect "sftp>" { send "mget $ar13\r"}
expect "sftp>" { send "mget $ar14\r"}
expect "sftp>" { send "mget $ar15\r"}
expect "sftp>" { send "mget $ar16\r"}
expect "sftp>" { send "mget $ar17\r"}
expect "sftp>" { send "mget $ar18\r"}
expect "sftp>" { send "mget $ar19\r"}
expect "sftp>" { send "mget $ar20\r"}
expect "sftp>" { send "mget $ar21\r"}
expect "sftp>" { send "mget $ar22\r"}
expect "sftp>" { send "mget $ar23\r"}
expect "sftp>" { send "mget $ar24\r"}
expect "sftp>" { send "mget $ar25\r"}
expect "sftp>" { send "mget $ar26\r"}
expect "sftp>" { send "mget $ar27\r"}
expect "sftp>" { send "mget $ar28\r"}
expect "sftp>" { send "mget $ar29\r"}
expect "sftp>" { send "mget $ar30\r"}
expect "sftp>" { send "mget $ar31\r"}
expect "sftp>" { send "bye\r"}
expect eof
