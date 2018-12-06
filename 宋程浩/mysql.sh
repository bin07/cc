#!/bin/bash
read -p "请输入ip最后一个字段：" i
expect << EOF
spawn ssh 192.168.4.$i
expect "pass"		{ send "123456\n"}
expect "#"		{ send "tar -xf mysql-5.7.17.tar\n"}
expect "#"		{ send "yum -y install perl-JSON\n"}
expect "#"		{ send "exit\n"}
expect "" 		{ send "1111\n"}
EOF 
&
