#!/bin/bash

file="/home/CEO"

if [[ -n $3 && $3 -ne 0 ]];
then 
	a=$(bc<<<"$3+$(cat ${file}/$2/$1/Current_Balance.txt)")
	[[ $(bc <<< "$a>=0") != 0 ]] && echo $a > ${file}/$2/$1/Current_Balance.txt
	[[ $(bc <<< "$a>=0") != 0 ]] && echo "$1 $3 `date +"%Y-%m-%d %T"`">>${file}/$2/$1/Transaction_History.txt
	[[ $(bc <<< "$a<0") != 0 ]] && echo "low balance availabel amount:$(cat ${file}/$2/$1/Current_Balance.txt)"
	php ${file}/php/transaction.php $1 $3
else
	echo "usuage: $0 <accountname> <BranchName> <amount(use minus for withdrawl)>"
fi
