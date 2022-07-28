#!/bin/bash

file="/home/CEO"
user=$USER
[[ -e $1 ]] && z=$1
> ${file}/src/summary.txt
> ${file}/src/mean.txt
> ${file}/src/meanusr.txt
> ${file}/src/median.txt
> ${file}/src/medianusr.txt
> ${file}/src/mode.txt
> ${file}/src/modeusr.txt
[[ "$user" != "CEO" ]] && user=$(echo $user |cut -d '_' -f 1)
[[ "$user" != "CEO" ]] &&[[ $# -eq 0 ]] && z="$file/$user/$user/Branch_Transaction_History.txt"
[[ "$user" == "CEO" ]] && z="$file/src/Transacion_List.txt" && unippl=$(awk '{print $1}' $z | sort | uniq | head -n -1)
[[ "$user" != "CEO" ]] && unippl=$(awk '{if($2 ==a){print $1}}' a=$user ${file}/src/User_Accounts.txt |sort | uniq)

for k in {1..12}
do
    min=0
    max=0
    echo "Month :$k" >> ${file}/src/medianusr.txt
    echo "Month:$k" >> ${file}/src/modeusr.txt
    for i in $unippl
    do
    	if [ $k -lt 10 ];
    	then
    		c="2022-0$k"
        	pt=$(awk '{if ($1==a&&$3~b)print $1"_"$3"_"$4"_"$2}' a=$i b=$c $z | sort)
            awk '{if ($1==a&&$3~b)print $1"\t"$2}' a=$i b=$c $z | sort -nk2 > ${file}/src/median.txt
            num=$(awk '{if ($1==a)print$1}' a=$i ${file}/src/median.txt | sort | uniq -c)
            num=$(echo $num |cut -d ' ' -f 1)
            [[ num%2 == 0 ]] && fn=$(((num/2)+1))
            [[ num%2 != 0 ]] && fn=$(((num+1)/2))
            cat ${file}/src/median.txt | head -n $fn | tail -1 >> ${file}/src/medianusr.txt
            awk '{if ($1==a&&$3~b)print $1"\t"$2}' a=$i b=$c $z > ${file}/src/mode.txt
            awk '{print $1"\t"$2}' ${file}/src/mode.txt | sort | uniq -c | head -n 1 >> ${file}/src/modeusr.txt

        else
        	c="2022-$k"
        	pt=$(awk '{if ($1==a&&$3~/2022-b/)print $1"_"$3"_"$4"_"$2}' a=$i b=$c $z | sort)
            awk '{if ($1==a&&$3~/2022-b/)print $1"\t"$2"\n"}' a=$i b=$c $z | sort -nk2 >> ${file}/src/median.txt
            num=$(awk '{if ($1==a)print$1}' a=$i ${file}/src/median.txt | sort | uniq -c)
            num=$(echo $num |cut -d ' ' -f 1)
            [[ num%2 == 0 ]] && fn=$(((num/2)+1))
            [[ num%2 != 0 ]] && fn=$(((num+1)/2))
            cat ${file}/src/median.txt | head -n $fn | tail -1 >> ${file}/src/medianusr.txt
            awk '{if ($1==a&&$3~/2022-b/)print $1"\t"$2}' a=$i b=$c $z > ${file}/src/mode.txt
            awk '{print $1"\t"$2}' ${file}/src/mode.txt | sort | uniq -c | head -n 1 >> ${file}/src/modeusr.txt
        fi
        if [[ ! -z $pt ]];
        then
            end=0
            start=0
            num=0
            for j in $pt
            do
                money=$(echo $j |cut -d '_' -f 4)
                [[ $start -eq 0 ]] && start=${money}
                num=$((num+1))
            end=$((money+end))
            done
            change=$((end-start))
            if [ "$change" -lt 0 ];
            then 
                change=${change#-}
            fi
            printf "$k $((end/num)) $i \n" >> ${file}/src/mean.txt
            printf "$k $i $change\n" >> ${file}/src/summary.txt
        fi
    done
    minn=$(awk '{if ($1==a)print $3"_"$2}' a=$k ${file}/src/summary.txt | sort -nk1| head -n 1)
    maxn=$(awk '{if ($1==a)print $3"_"$2}' a=$k ${file}/src/summary.txt | sort -nk1| tail -n 1)
    min=$(echo $minn |cut -d '_' -f 1)
    minacc=$(echo $minn |cut -d '_' -f 2)
    max=$(echo $maxn |cut -d '_' -f 1)
    maxacc=$(echo $maxn |cut -d '_' -f 2)
    echo "Month:$k" >> ${file}/src/meanusr.txt
    awk '{if ($1==a)print $3"\t"$2}' a=$k ${file}/src/mean.txt >> ${file}/src/meanusr.txt
    [[ $max -ne 0 ]] && echo "Month:$k ,Max Change:$maxacc by $max ,Min Change:$minacc by ${min}"
done
> ${file}/src/summary.txt
> ${file}/src/mean.txt
> ${file}/src/median.txt
> ${file}/src/mode.txt

cp /home/CEO/src/*usr.txt /var/www/omega/Statistics
