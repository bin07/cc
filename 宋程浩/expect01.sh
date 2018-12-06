#!/bin/bash
read -p "请输入要配置的序号：" i
read -p "请输入主机名：" p
read -p "请输入配置IP：" j
expect << EOF
spawn virsh console rh7_node$i
expect "换码符"		{ send "\n"}
expect "login"		{ send "root\n"}
expect "密码"		{ send "123456\n"}
expect "#"		{ send "echo $p > /etc/hostname\n"	}
expect "#"		{ send "nmcli connection modify eth0 ipv4.method manual ipv4.addresses $j/24 connection.autoconnect yes\n"}
expect "#"		{ send "nmcli connection up eth0\n"}
expect "#"		{ send "yum-config-manager --add ftp://192.168.4.254/rhel7\n"}
expect "#"		{ send "sed -i '5a gpgcheck=0' /etc/yum.repos.d/192.168.4.254_rhel7.repo\n"}
expect "#"		{ send "echo rh7_node$i\n"}
expect "#"		{ send "reboot\n"}
expect "" 		{ send "^]\n"}
expect "#"		{ send "exit\n"}
EOF
#done
