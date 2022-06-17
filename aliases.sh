#! /bin/bash

file="/home/CEO"
sudo apt install bc

#sudo useradd -m -d /home/CEO CEO

#sudo mv permit.sh makeTransaction.sh updateBranch.sh init.sh genUser.sh genSummary.sh allotInterest.sh /usr/local/sbin

echo "alias genUser='/home/CEO/genUser.sh'" >> /home/CEO/.bashrc
echo "alias permit='/home/CEO/permit.sh'" >> /home/CEO/.bashrc
echo "alias updateBranch='/home/CEO/updateBranch.sh'" >> /home/CEO/.bashrc
echo "alias allotInterest='/home/CEO/allotInterest.sh'" >> /home/CEO/.bashrc
echo "alias makeTransaction='/home/CEO/makeTransaction.sh'" >> /home/CEO/.bashrc
echo "alias genSummary='/home/CEO/genSummary.sh'" >> /home/CEO/.bashrc
source /home/CEO/.bashrc


for j in $(ls -d Branch*)
do
    cd $j
    for i in $(ls -d ACC*)
    do
    	echo "alias makeTransaction='/home/CEO/makeTransaction.sh'" >> /home/CEO/$j/$i/.bashrc
    	source /home/CEO/$j/$i/.bashrc
    done
    echo "alias updateBranch='/home/CEO/updateBranch.sh'" >> /home/CEO/$j/$j/.bashrc
    echo "alias allotInterest='/home/CEO/allotInterest.sh'" >> /home/CEO/$j/$j/.bashrc
    echo "alias makeTransaction='/home/CEO/makeTransaction.sh'" >> /home/CEO/$j/$j/.bashrc
    echo "alias genSummary='/home/CEO/genSummary.sh'" >> /home/CEO/$j/$j/.bashrc
    cd ..
    source /home/CEO/$j/$j/.bashrc
done

crontab -l > cron
echo "* * * * *  ${file}/allotInterest.sh" >>cron
crontab cron
rm cron
