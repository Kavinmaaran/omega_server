#!/bin/bash

file="/home/CEO"
chmod 777 /home/CEO

if [[  $# -eq 0 ]];
then
	value=$(awk '{print $1$2}' ${file}/src/User_Accounts.txt )
	for i in $value
	do
		sudo useradd -m -d ${file}/${i:7:7}/${i:0:7} ${i:0:7}
		sudo touch ${file}/${i:7:7}/${i:0:7}/Transaction_History.txt
		sudo echo "500">${file}/${i:7:7}/${i:0:7}/Current_Balance.txt
	done

	value=$(awk '{print $2}' ${file}/src/User_Accounts.txt | sort | uniq)
	for i in $value
	do
		sudo useradd -m -d ${file}/${i}/${i} ${i}_manager
		sudo touch ${file}/${i}/${i}/Branch_Transaction_History.txt
		sudo touch ${file}/${i}/${i}/Branch_Current_Balance.txt
		sudo wget -O ${file}/${i}/${i}/Daily_Interest_Rates.txt inductions.delta.nitt.edu/sysad-task1-Daily_Interest_Rates.txt
	done
fi

if [[  $# -eq 5 ]];
then
	sudo useradd -m -d ${file}/$2/$1 $1
	sudo touch ${file}/$2/$1/Transaction_History.txt
	sudo echo "500">${file}/$2/$1/Current_Balance.txt
	sudo echo "$1 $2 $3 $4 $5">>${file}/src/User_Accounts.txt
		
fi
