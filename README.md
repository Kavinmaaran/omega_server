# DeltaTask1_SysAd

## Omega Bank Server Setup

## To sign in a user:
``sudo -u <username> bash``

## While starting a new server
``apt update``  
``apt -y upgrade``     
``apt install sudo acl wget git``   

### Apply these commands to get started:

``sudo useradd -m -d /home/CEO CEO``  
``cd /home/CEO``    
sign in to User CEO   
``git clone https://github.com/kavin033/DeltaTask1_SysAd.git``  
``mv DeltaTask1_SysAd/init.sh .``  
``chmod +x init.sh``  
``./init.sh``   

#### sign in to Root user while using ``genUser.sh`` and ``permit.sh``  

In genSummary.sh the mean median and mode of each user is exported to:  
1. mean - /home/CEO/src/meanusr.txt  
2. median - /home/CEO/src/medianusr.txt
3. mode - /home/CEO/src/modeusr.txt

For CEO no need of argument while using genSUmmary.  
For Branch managers if no arguments given it takes users from there branch.    
Branch manger to get genSummary of a text file its location can be given as argument.   
* for example ``genSummary /home/CEO/src/Transacion_List.txt``  
