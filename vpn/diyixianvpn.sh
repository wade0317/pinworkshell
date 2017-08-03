#!/bin/bash
PASSWORD=
WIFI_CMD=$1

CURRENT_DIR=$(cd `dirname $0`; pwd)

IS_PASSWORD_RIGHT="N"

while  [[ $IS_PASSWORD_RIGHT == "N" ]]
do

sudo -k
if sudo -lS &> /dev/null << EOF
$PASSWORD
EOF
then
	IS_PASSWORD_RIGHT="Y"
else 
	echo 'Please enter your password:'
	read -s PASSWORD
fi

done 

FILE_NAME=".sh"
if [[ $0 =~ $FILE_NAME ]]; then
	echo $PASSWORD | sudo -S mv $0 /usr/local/bin/diyixianvpn
	echo $PASSWORD | sudo -S chmod 777 /usr/local/bin/diyixianvpn
	echo Install Done !!!
	echo Use Command: 'diyixianvpn' or 'diyixianvpn off' 
fi


if [[ $WIFI_CMD == "off" ]]; then
echo $PASSWORD | sudo -S networksetup -setdnsservers Wi-Fi empty
echo $PASSWORD | sudo -S networksetup -setdhcp Wi-Fi
echo diyixian VPN is off now！ 
elif [[ condition ]]; then
IP_ADDRESS=`ifconfig | grep "inet 192" | awk '{print $2}'`
echo My Ip is: $IP_ADDRESS
echo $PASSWORD | sudo -S networksetup -setdnsservers Wi-Fi empty
echo $PASSWORD | sudo -S networksetup -setmanual Wi-Fi $IP_ADDRESS 255.255.252.0 192.168.9.3
echo $PASSWORD | sudo -S networksetup -setdnsservers Wi-Fi 152.104.228.243
echo diyixian VPN is ok now！
fi

# networksetup -getdnsservers Wi-Fi
# 114.114.114.114
# 8.8.8.8
