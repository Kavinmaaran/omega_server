#!/bin/bash

file="/home/CEO"
user=$USER
if [[ $user == "CEO" ]];
then
    user=Branch*
else
    user=$(echo $user |cut -d '_' -f 1)
fi
for j in $(ls -d ${user})
do
    cd $j
    count=0
    for i in $(ls -d ACC*)
    do
	a=$(cat ${file}/$j/${i}/Current_Balance.txt)
	count=$(bc -l <<< "$count+$a")
        (cat ${file}/$j/${i}/Transaction_History.txt) >> ${file}/$j/$j/Branch_Transaction_History.txt
    done
    echo $count >${file}/$j/$j/Branch_Current_Balance.txt
    cd ..
done
