#!/bin/bash

fail=0
BACKUPFOLDER="/media/cpt-n3m0/Storage/Backups/"
LOGFILE="/home/cpt-n3m0/Scripts/logs/backup.log"

old_backup=$(ls /media/cpt-n3m0/Storage/Backups/home_*) || old_backup=''
tmp=/media/cpt-n3m0/Storage/Backups/~$(basename $old_backup)
mv $old_backup $tmp 
old_backup=$tmp
new_backup=/media/cpt-n3m0/Storage/Backups/home_$(date +%F).tgz
number_of_backups=$(ls -l /media/cpt-n3m0/Storage/Backups | wc -l)

if [[ $number_of_backups -gt 5 ]]
then
	echo cleaning up old backups
	toremove=$BACKUPFOLDER$(ls -lt $BACKUPFOLDER | tail -n 1 | awk '{printf("%s ", $9)}')
	rm $toremove -f
fi

echo compressing ...
tar -zcvf $new_backup /home/ --warning=no-file-changed 

if [[ $( ls $BACKUPFOLDER/home_*) -eq "" ]]
then
	echo "[$(date +"%F %X")] Error: Compression failed" >> $LOGFILE
	exit -2
else
	echo "[$(date +"%F %X")] Success: $new_backup created" >> $LOGFILE

fi

if [[ $(cat /proc/mounts | grep Storage) == "" ]]
then
	echo "[$(date +"%F %X")] Error: Storage not mounted" >> $LOGFILE
	exit -1
fi



#if [[ $(ping 192.168.0.22 -c 1| grep errors) == "" ]] 
#then
	#host=192.168.0.22
#else
	#host=$(./getIp) #to find my computer over the internet (requires port forwarding to be setup on the router)
#fi

#echo  Ready.
#echo Sending to cpt-n3m0@$host ...
#scp $new_backup cpt-n3m0@$host:Backups || fail=1

#if [[ $fail -eq 1 ]]
#then
	#echo "[$(date +"%F %X")] Error: Transfer to dataNaut failed  " >> $LOGFILE
#else
	#echo "[$(date +"%F %X")] Success: $new_backup transfered to cpt-n3m0@$host " >> $LOGFILE
#fi
#echo success.
#echo cleaning ...
#rm  $old_backup || fail=2 
#if [[ $fail -eq 2 ]]
#then
	#echo "[$(date +"%F %X")] Error: removing $old_backup failed " >> $LOGFILE
	#exit -3
#else
	#echo "[$(date +"%F %X")] Success: removed $old_backup" >> $LOGFILE
#fi
echo "[$(date +%X)] Success: Backup successful" >> $LOGFILE
echo success

