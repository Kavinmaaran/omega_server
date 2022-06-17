#!/bin/bash

file="/home/CEO"
user=$USER
value=$(awk '{print $1"_"$2"_"$3"_"$4"_"$5}' ${file}/src/User_Accounts.txt)
for i in $value
do
	declare -A intrest
	branch=$(echo $i |cut -d '_' -f 2)
	if [[ $user != "CEO" ]];
	then
		z=$(echo $user |cut -d '_' -f 1)
		[[ $z != $branch ]] && continue
	fi
	values=$(awk '{print $1"_"$2}' ${file}/${branch}/${branch}/Daily_Interest_Rates.txt )
	for j in $values
	do
	key=$(echo $j |cut -d '_' -f 1)
	values=$(echo $j |cut -d '_' -f2-)
	values=${values::-2}
	intrest[$key]=$values 
	done
	intrests=0
	person=$(echo $i |cut -d '_' -f 1)
	a=$(cut -d '_' -f 3 <<< "$i")
	b=$(cut -d '_' -f 4 <<< "$i")
	c=$(cut -d '_' -f 5 <<< "$i")
	a=${intrest[$a]}
	b=${intrest[$b]}
	c=${intrest[$c]}
	[[ -n $a ]] && intrests=$(bc <<< "$intrests+$a")
	[[ -n $b ]] && intrests=$(bc <<< "$intrests+$b")
	[[ -n $c ]] && intrests=$(bc <<< "$intrests+$c")
	p=$(cat ${file}/${branch}/${person}/Current_Balance.txt)
	money=$(bc -l <<< "($intrests*$p)/(100*365)")
	money=$(bc -l <<< "$money+$p")
	echo $money > ${file}/${branch}/${person}/Current_Balance.txt
done


