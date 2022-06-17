#! /bin/bash

file="/home/CEO"

mv /home/CEO/DeltaTask1_SysAd/* /home/CEO/
mv /home/CEO/'NormalUser Mode'/* /home/CEO/
mv /home/CEO/'SuperUser Mode'/* /home/CEO/
rm -rf /home/CEO/'NormalUser Mode'   /home/CEO/README.md  /home/CEO/'SuperUser Mode' /home/CEO/DeltaTask1_SysAd
chmod 770 ${file}/allotInterest.sh ${file}/genSummary.sh ${file}/updateBranch.sh ${file}/src/summary.txt ${file}/src/mean.txt ${file}/src/meanusr.txt ${file}/src/mode.txt ${file}/src/modeusr.txt ${file}/src/median.txt ${file}/src/medianusr.txt
chmod 700 ${file}/aliases.sh ${file}/genUser.sh ${file}/init.sh ${file}/permit.sh 
chmod 777 ${file}/makeTransaction.sh
